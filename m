Message-Id: <4.2.0.25.19990224170223.009a5a80@mail.lauterbach.com>
Date: Wed, 24 Feb 1999 17:06:59 +0100
To: Gary Thomas <gdt@linuxppc.org>, Tom Vier <thomassr@erols.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: egcs-1.1.1-1c bug (was Re: major ksyms problem)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <XFMail.990224095316.gdt@linuxppc.org>
References: <99022322220600.00836@ns1102.munich.netsurf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:53 24.02.99 , Gary Thomas wrote:

>On 23-Feb-99 Franz Sirl wrote:
>>
>> Am Tue, 23 Feb 1999 schrieb Tom Vier:
>>>On Tue, 23 Feb 1999, Franz Sirl wrote:
>>>
>>>> At 15:36 22.02.99 , Tom Vier wrote:
>>>> >
>>>> >it's an egcs bug. i think it's not aligning instructions properly, cuz
>>>> >i believe the 601 is more strict about alignment. is anyone having
>>>> >problems using bsd_comp.o, ppp_deflate.o, and hfs.o on a non-601
>>>> >machine built under pre-R5 (egcs-1.1.1-1c)?
>>>>
>>>> What makes you think that it is an egcs bug? I have no problems on 601
>>>> (7200/75) with any of the modules you listed. Are you sure you have the
>>>> latest modutils (2.1.121 or later) installed?
>>>
>>>it is an egcs bug. egcs-1.1.1-1c failss to build working bsd_comp.o,
>>>ppp_deflate.o, and hfs.o; egcs-1.0-2e.ppc.rpm builds it perfectly. i'm
>>>getting a newer build of egcs right now, to see if it's fixed.
>>
>> What is the problem with these modules? Give a better description on 
>> what you
>> mean with "working"? They work perfectly for me with a self-compiled 2.2.1
>> kernel, and I compiled working modules with multiple kernel versions 
>> since the
>> egcs-1.1 alpha phase.
>> If your only problem is the "unhandled relocation type", install a newer
>> modutils package (>=2.1.121), that will fix it.
>>
>
>Sadly he can't use that modutils package as it's only for 2.1.xx and 2.2.xx
>kernels.
>
>Tom,  Can you try the 2.2.xx kernels and see if they work for you?  This would
>be a much better way to spend your time rather than looking after a quite old
>kernel.

Or try to recompile the modutils (or modules package, as it was called 
before) he is using with the appended patch.

Franz.

Index: obj_ppc.c
===================================================================
RCS file: /cvsroot/modutils/obj/obj_ppc.c,v
retrieving revision 1.1
diff -u -r1.1 obj_ppc.c
--- obj_ppc.c   1997/09/10 22:20:03     1.1
+++ obj_ppc.c   1998/06/24 01:47:42
@@ -148,6 +148,11 @@
       *loc = (*loc & ~0x03fffffc) | (v & 0x03fffffc);
       break;

+    case R_PPC_REL32:
+      v -= dot;
+      *loc = v;
+      break;
+
     case R_PPC_ADDR32:
       *loc = v;
       break;


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
