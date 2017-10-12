Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCHtV3s8QzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 15:29:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kamalesh@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/modules: Use WARN_ON() in stub_for_addr()
In-Reply-To: <c2a00841-f514-ef8c-c1be-b053dd84d1b8@linux.vnet.ibm.com>
References: <1507646852-18642-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <87d15uz5j9.fsf@concordia.ellerman.id.au>
 <c2a00841-f514-ef8c-c1be-b053dd84d1b8@linux.vnet.ibm.com>
Date: Thu, 12 Oct 2017 15:29:22 +1100
Message-ID: <87bmld2dlp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:

> On Wednesday 11 October 2017 09:42 AM, Michael Ellerman wrote:
>> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:
>> 
>>> Use WARN_ON(), while running out of stubs in stub_for_addr()
>>> and abort loading of the module instead of BUG_ON().
>> 
>> Thanks. This looks good in principle. Have you actually tested it to
>> make sure we do in fact gracefully fail the module load?
>> 
>
> Thanks for the review. I tested with little hackish version of this patch:
>
> +       if (!strncmp(me->name, "live", 4))
> +               j = 100;
> +       for (i = 0; stub_func_addr(stubs[i].funcdata); i+=j) {
> +               if (WARN_ON(i >= num_stubs))
> +                       return 0;
>
> and it fails gracefully.
>
> # modprobe livepatch-sample
> modprobe: ERROR: could not insert 'livepatch_sample': Unknown symbol in module, or unknown parameter (see dmesg)
>
> # echo $?
> 1
>
> # dmesg 
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 2836 at arch/powerpc/kernel/module_64.c:526 apply_relocate_add+0x71c/0xb00

Thanks.

cheers
