Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEFC61A009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 00:52:17 +1100 (AEDT)
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 628421402DE
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 00:52:17 +1100 (AEDT)
Received: by mail-pf0-x236.google.com with SMTP id 124so13550083pfg.0
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Mar 2016 05:52:17 -0800 (PST)
Subject: Re: [v5][PATCH] livepatch/ppc: Enable livepatching on powerpc
To: Torsten Duwe <duwe@lst.de>
References: <1457422437-3357-1-git-send-email-bsingharora@gmail.com>
 <20160308104552.GA16502@lst.de>
Cc: linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, jikos@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56DED903.2000209@gmail.com>
Date: Wed, 9 Mar 2016 00:52:03 +1100
MIME-Version: 1.0
In-Reply-To: <20160308104552.GA16502@lst.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/03/16 21:45, Torsten Duwe wrote:
> On Tue, Mar 08, 2016 at 06:33:57PM +1100, Balbir Singh wrote:
>> Changelog v5:
>> 	1. Removed the mini-stack frame created for klp_return_helper.
>> 	   As a result of the mini-stack frame, function with > 8
>> 	   arguments could not be patched
> Did you get my previous mails? Those functions only require special
> care, the _can_ be patched. In general, writing replacement functions
> always requires attention!
Yes, I did. We did think about documenting that limitation, but the big concern
was that the system can be panic'd with a simple test case. We expect live patches
to be tested and signed so we should be OK, but there still is a window
> Have you *tested* this patch? Replacing a function in the kernel?
> Replacing a function in a module? For local calls? For global calls?
> I strongly doubt so because it does not work this way.
Yes, if you care to read the changelog
"

I tested the sample in the livepatch and an additional sample
that patches int_to_scsilun. I'll post out that sample if there
is interest later. I also tested ftrace functionality on the
command line to check for breakage"

I've tested patching calls from module to module
(ibmvscsi to scsi_mod), within the kernel (livepatch-sample/
proc_cmdline_show). I must admit there is more testing to
be done

> To be fair, my last mail still was not 100% correct, but the conclusion
> that the mini frame is not needed at all is invalid. Please leave it as it
> was, I'm working on a test / demonstrator for how to handle these.
Why, the magic will be in the patched function? Please share the test/demonstrator
>> +	 * Why do we need this?
>> +	 * After patching we need to return to a trampoline return function
>> +	 * that guarantees that we restore the TOC and return to the correct
>> +	 * caller back
>> +	 */
>> +	std	r2, 24(r1)	/* save TOC now, unconditionally. */
>> +	subf	r0, r2, r0	/* Calculate offset from current TOC */
>> +	stw	r0, 12(r1)	/* Of the final LR and save it in CR+4 */
>> +	bl	5f
>> +5:	mflr	r12
>> +	addi	r12, r12, (klp_return_helper + 4 - .)@l
>> +	std	r12, LRSAVE(r1)
> [...]
>> + * maybe inserting a klp_return_helper frame or not.
>> +*/
>> +klp_return_helper:
>> +	ld	r2, 24(r1)	/* restore TOC (saved by ftrace_caller) */
>> +	lwa	r0, 12(r1)	/* Load from CR+4, offset of LR w.r.t TOC */
>> +	add	r0, r0, r2	/* Add the offset to current TOC */
>> +	std	r0, LRSAVE(r1)	/* save the real return address */
>> +	mtlr	r0
>> +	blr
>> +#endif
> NAKed-by: Torsten Duwe <duwe@suse.de>
Why? For using CR+4 or removing the frame? Or you believe there is a better way to
handle this that work, IOW what is broken?
>
> 	Torsten
>
Balbir Singh
