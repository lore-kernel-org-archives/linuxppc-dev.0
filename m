Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4F3BB7B8F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 19:56:47 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n978kFtM005393
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2009 19:46:15 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n978uhT3471314
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2009 19:56:44 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n978uhjo014682
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2009 19:56:43 +1100
Message-ID: <4ACC57C4.5010002@in.ibm.com>
Date: Wed, 07 Oct 2009 14:26:36 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: rostedt@goodmis.org
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>	<1252814877.26049.93.camel@gandalf.stny.rr.com>
	<1252816650.8375.70.camel@pasglop>
	<1252848060.26049.647.camel@gandalf.stny.rr.com>
	<1252873548.8375.73.camel@pasglop>
	<1252915227.8375.118.camel@pasglop>
	<1254749155.13160.6.camel@gandalf.stny.rr.com>
	<1254774039.7122.35.camel@pasglop>
	<1254775073.13160.13.camel@gandalf.stny.rr.com>
In-Reply-To: <1254775073.13160.13.camel@gandalf.stny.rr.com>
Content-Type: multipart/mixed; boundary="------------000505010507050106030503"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000505010507050106030503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Steven Rostedt wrote:
> On Tue, 2009-10-06 at 07:20 +1100, Benjamin Herrenschmidt wrote:
>   
>> On Mon, 2009-10-05 at 09:25 -0400, Steven Rostedt wrote:
>>     
>>>>> Sachin, can you give me more details on how you built that kernel ? (or
>>>>> give them again in case I missed them the first time around :-), ie,
>>>>> what toolchain, options, etc... or even better, give me remote access to
>>>>> the build host ?
>>>>>           
>>>> Ok, got access and had a quick look... seems to be a toolchain problem
>>>> to me. I'll investigate more tomorrow.
>>>>         
>>> Hi Ben,
>>>
>>> Any more word on this issue? 
>>>       
>> Didn't you fix it using a TOC access ?
>>
>> Unless I'm confusing things, I think the problem is the usage
>> of LOAD_REG_IMMEDIATE which generates relocs that we don't support
>> when CONFIG_RELOCATABLE is set.
>>
>> I've merged a patch that post-processes the kernel now, to check
>> for such relocs so at least you should be warned at build time.
>>     
>
> I thought we had two issues. One was the use of the relocs that did
> cause issues. But then there was still crashes reported after that.
> IIRC. I'm still suffering jetlag, so my memory is not that fresh about
>   
As Ben suggested, i changed LOAD_REG_IMMEDIATE() to LOAD_REG_ADDR()
as follows.

-       LOAD_REG_IMMEDIATE(r4,ftrace_return_to_handler)
+       LOAD_REG_ADDR(r4,ftrace_return_to_handler)

With this change compile time warnings about bad relocations
related to ftrace are gone.

Before the change :
WARNING: 6 bad relocations
c000000000008f1a R_PPC64_ADDR16_HIGHEST  __ksymtab+0x0000000000742110
c000000000008f1e R_PPC64_ADDR16_HIGHER  __ksymtab+0x0000000000742110
c000000000008f26 R_PPC64_ADDR16_HI  __ksymtab+0x0000000000742110
c000000000008f2a R_PPC64_ADDR16_LO  __ksymtab+0x0000000000742110
c00000000085e118 R_PPC64_ADDR64    __crc_per_cpu__softirq_work_list
c0000000008662d0 R_PPC64_ADDR64    __crc_simple_prepare_write

After the change :
WARNING: 2 bad relocations
c00000000085e118 R_PPC64_ADDR64    __crc_per_cpu__softirq_work_list
c0000000008662d0 R_PPC64_ADDR64    __crc_simple_prepare_write

But i still run into oops while using ftrace function_graph.

Thanks
-Sachin



-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------000505010507050106030503
Content-Type: text/x-patch;
 name="fix-ftrace-bad-relocs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-ftrace-bad-relocs.patch"

diff -Naurp a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
--- a/arch/powerpc/kernel/entry_64.S	2009-10-06 15:31:29.000000000 +0530
+++ b/arch/powerpc/kernel/entry_64.S	2009-10-06 15:34:00.000000000 +0530
@@ -1038,7 +1038,7 @@ _GLOBAL(mod_return_to_handler)
 	 * We are in a module using the module's TOC.
 	 * Switch to our TOC to run inside the core kernel.
 	 */
-	LOAD_REG_IMMEDIATE(r4,ftrace_return_to_handler)
+	LOAD_REG_ADDR(r4,ftrace_return_to_handler)
 	ld	r2, 8(r4)
 
 	bl	.ftrace_return_to_handler

--------------000505010507050106030503--
