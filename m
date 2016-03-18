Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRLJF5l8KzDqgb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 20:58:05 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id x188so4703709wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 02:58:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH kernel] KVM: PPC: Create a virtual-mode only TCE table
 handlers
To: Paul Mackerras <paulus@ozlabs.org>, Alexey Kardashevskiy <aik@ozlabs.ru>
References: <1458269442-24292-1-git-send-email-aik@ozlabs.ru>
 <20160318091629.GD1393@fergus.ozlabs.ibm.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
 David Gibson <david@gibson.dropbear.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56EBD126.6060307@redhat.com>
Date: Fri, 18 Mar 2016 10:57:58 +0100
MIME-Version: 1.0
In-Reply-To: <20160318091629.GD1393@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 18/03/2016 10:16, Paul Mackerras wrote:
> On Fri, Mar 18, 2016 at 01:50:42PM +1100, Alexey Kardashevskiy wrote:
>> Upcoming in-kernel VFIO acceleration needs different handling in real
>> and virtual modes which makes it hard to support both modes in
>> the same handler.
>>
>> This creates a copy of kvmppc_rm_h_stuff_tce and kvmppc_rm_h_put_tce
>> in addition to the existing kvmppc_rm_h_put_tce_indirect.
>>
>> This also fixes linker breakage when only PR KVM was selected (leaving
>> HV KVM off): the kvmppc_h_put_tce/kvmppc_h_stuff_tce functions
>> would not compile at all and the linked would fail.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Acked-by: Paul Mackerras <paulus@samba.org>
> 
> Paolo, will you take this directly, or do you want me to generate
> a pull request?

I can take it directly.

Paolo
