Return-Path: <dsahern@gmail.com>
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com
 [IPv6:2607:f8b0:4001:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 385A21A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 03:11:45 +1100 (AEDT)
Received: by igcpe7 with SMTP id pe7so18232600igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2015 09:11:42 -0700 (PDT)
Subject: Re: [PATCH v9 1/4] perf,kvm/{x86,s390}: Remove dependency on
 uapi/kvm_perf.h
To: Hemant Kumar <hemant@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
References: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, acme@kernel.org, scottwood@freescale.com,
 sukadev@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 mpe@ellerman.id.au, paulus@samba.org, mingo@redhat.com,
 yarygin@linux.vnet.ibm.com, borntraeger@de.ibm.com, srikar@linux.vnet.ibm.com
From: David Ahern <dsahern@gmail.com>
Message-ID: <5615443F.7030909@gmail.com>
Date: Wed, 7 Oct 2015 10:11:43 -0600
MIME-Version: 1.0
In-Reply-To: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/6/15 8:25 PM, Hemant Kumar wrote:
> @@ -358,7 +357,12 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
>   	time_diff = sample->time - time_begin;
>
>   	if (kvm->duration && time_diff > kvm->duration) {
> -		char decode[DECODE_STR_LEN];
> +		char *decode = zalloc(decode_str_len);

decode can still be a stack variable even with variable length.

> +
> +		if (!decode) {
> +			pr_err("Not enough memory\n");
> +			return false;
> +		}
>
>   		kvm->events_ops->decode_key(kvm, &event->key, decode);
>   		if (!skip_event(decode)) {
> @@ -366,6 +370,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
>   				 sample->time, sample->pid, vcpu_record->vcpu_id,
>   				 decode, time_diff/1000);
>   		}
> +		free(decode);
>   	}
>
>   	return update_kvm_event(event, vcpu, time_diff);
> @@ -386,7 +391,8 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,

-----8<-----

> @@ -575,7 +581,7 @@ static void show_timeofday(void)
>
>   static void print_result(struct perf_kvm_stat *kvm)
>   {
> -	char decode[DECODE_STR_LEN];
> +	char *decode;

and a stack variable here too.

David
