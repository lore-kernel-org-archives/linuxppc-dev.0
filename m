Return-Path: <manoj.shar@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.198])
	by ozlabs.org (Postfix) with ESMTP id 1390267A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 11:28:25 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so1451476nzh
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Sep 2006 18:28:23 -0700 (PDT)
Message-ID: <d6dada100609181828j1804f4f5ic0d1dd8a225980c@mail.gmail.com>
Date: Mon, 18 Sep 2006 18:28:23 -0700
From: "Manoj Sharma" <manoj.shar@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Hang with isync
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_157957_2709642.1158629303367"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_157957_2709642.1158629303367
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

We use linux kernel 2.4.20 on ppc405 and the system hangs once in a while
when isync gets called in this function:

_GLOBAL(_nmask_and_or_msr)
    mfmsr   r0      /* Get current msr */
    andc    r0,r0,r3    /* And off the bits set in r3 (first parm) */
    or  r0,r0,r4    /* Or on the bits in r4 (second parm) */
    sync            /* Some chip revs have problems here... */
    isync
    mtmsr   r0      /* Update machine state */
    isync
    blr         /* Done */

 2.5 onwards, I find that "sync; isync" has been replaced by a macro SYNC
(defined only for 601). I don't find it in any changelog and reason for the
change.

Can someone give some information on this change?

Appreciate any help.
Manoj

<linuxppc-dev@ozlabs.org>

------=_Part_157957_2709642.1158629303367
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>We use linux kernel 2.4.20 on ppc405 and the system hangs once in a while when isync gets called in this function:<br><br>_GLOBAL(_nmask_and_or_msr)<br>&nbsp;&nbsp;&nbsp; mfmsr&nbsp;&nbsp; r0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get current msr */<br>&nbsp;&nbsp;&nbsp; andc&nbsp;&nbsp;&nbsp; r0,r0,r3&nbsp;&nbsp;&nbsp; /* And off the bits set in r3 (first parm) */
<br>&nbsp;&nbsp;&nbsp; or&nbsp; r0,r0,r4&nbsp;&nbsp;&nbsp; /* Or on the bits in r4 (second parm) */<br>&nbsp;&nbsp;&nbsp; sync&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Some chip revs have problems here... */<br>&nbsp;&nbsp;&nbsp; isync<br>&nbsp;&nbsp;&nbsp; mtmsr&nbsp;&nbsp; r0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update machine state */<br>&nbsp;&nbsp;&nbsp; isync<br>&nbsp;&nbsp;&nbsp; blr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Done */
<br><br>&nbsp;2.5 onwards, I find that &quot;sync; isync&quot; has been replaced by a macro SYNC (defined only for 601). I don't find it in any changelog and reason for the change.<br><br>Can someone give some information on this change? 
<br><br>Appreciate any help.<br>Manoj<br><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:linuxppc-dev@ozlabs.org"></a>

------=_Part_157957_2709642.1158629303367--
