Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id CCB2367B6D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 09:37:20 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so941853nzh
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 16:37:19 -0700 (PDT)
Message-ID: <198592450608281637v57e5921dsa034afcafa4193db@mail.gmail.com>
Date: Mon, 28 Aug 2006 23:37:18 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: "Reddy Suneel-ASR125" <suneel.reddy@motorola.com>
Subject: Re: How to boot powerPC linux-2.6.10 from diifferent address other
	than 0x0000
In-Reply-To: <405ECA8A30557F439A723E52D50838F9D372AB@ZMY16EXM66.ds.mot.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_134694_30746382.1156808238937"
References: <405ECA8A30557F439A723E52D50838F9D372AB@ZMY16EXM66.ds.mot.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_134694_30746382.1156808238937
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You need to do two things:
- mem remap your boot sector memory block to virtual address 0xc0008000
- using uboot commond "go xxx" to boot it from 0xc0008000, or define env
variable "bootcmd", and run "boot".


On 8/25/06, Reddy Suneel-ASR125 <suneel.reddy@motorola.com> wrote:
>
>   Hi,
>     We are working on MPC 8540, Linux kernel version is 2.6.10 from
> Montavista. The bootloader used in Uboot and currently it loads the uImage
> at physical memory address 0x0 and transfers control to it. We want to load
> the kernel at a different address say 0x8000 and for this we made the
> following changes.
>
> 1) Altered the Makefile to linked the kernel at virtual address 0xc0008000
> ( the default was 0xc000:0000)
> 2) Modified Uboot to load kernel at 0x8000 instead of 0x0
>
> The kernel space still starts from 0xc000:0000
>
> When we transferred control to the kernel (loaded at 0x8000) we found that
> the execution proceeds only till the mapping and invalidation on TLBs. We do
> not know where the control goes after this as the further instructions does
> not seems to get executed. Currently we do not have the provision to connect
> a debugger and hence we are unable to make out what is happening.
>
> Can some one give us any clue as to what we might have done wrong? This is
> our first experience on PowerPC.
>
>
> Thanks&regards
> Suneel
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>

------=_Part_134694_30746382.1156808238937
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You need to do two things:<br>
- mem remap your boot sector memory block to virtual address <span><font face="Arial" size="2">0xc0008000<br>
- using uboot commond &quot;go xxx&quot; to boot it from </font></span><span><font face="Arial" size="2">0xc0008000, or define env variable &quot;bootcmd&quot;, and run &quot;boot&quot;.<br>
<br>
</font></span><br><div><span class="gmail_quote">On 8/25/06, <b class="gmail_sendername">Reddy Suneel-ASR125</b> &lt;<a href="mailto:suneel.reddy@motorola.com">suneel.reddy@motorola.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>





<div>
<div>
<div>
<div><span><font face="Arial" size="2">Hi,</font></span></div>
<div><span><font face="Arial" size="2">&nbsp;&nbsp;&nbsp; 
We are working on MPC 8540, Linux kernel version is 2.6.10 from Montavista. The 
bootloader used in Uboot and currently it loads the uImage at physical memory 
address 0x0 and transfers control to it. We want to load the kernel at a 
different address say 0x8000 and for this we made the following 
changes.</font></span></div>
<div><span><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font face="Arial" size="2">1) Altered the 
Makefile to linked the kernel at virtual address 0xc0008000 ( the default was 
0xc000:0000)</font></span></div>
<div><span><font face="Arial" size="2">2) Modified Uboot to 
load kernel at 0x8000 instead of 0x0</font></span></div>
<div><span><font face="Arial" size="2">
<p><span>The kernel space still starts from 
0xc000:0000</span></p></font></span></div>
<div><span><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font face="Arial" size="2">When we transferred 
control to the kernel (loaded at 0x8000) we found that the execution proceeds 
only till the mapping and invalidation on TLBs.&nbsp;We do not know where the 
control goes after this as the further instructions does not seems to get 
executed. Currently we do not have the provision to connect a debugger and hence 
we are unable to make out what is happening.</font></span></div>
<div><span><font face="Arial" size="2"></font></span>&nbsp;</div>
<div><span><font face="Arial"><font size="2">Can some one 
give us any clue as to what we might have done wrong? This is our first 
experience on PowerPC<span>.</span></font></font></span></div>
<div><span><font face="Arial"><font size="2"><span></span></font></font></span>&nbsp;</div>
<div><span><font face="Arial"><font size="2"><span></span></font></font></span>&nbsp;</div>
<div><span><font face="Arial"><font size="2"><span>Thanks&amp;regards</span></font></font></span></div>
<div><span><font face="Arial"><font size="2"><span>Suneel</span></font></font></span></div></div></div></div>

</div><br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org
</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br><br></blockquote>
</div><br>

------=_Part_134694_30746382.1156808238937--
