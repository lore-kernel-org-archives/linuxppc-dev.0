Message-Id: <l03130301b8351d769a73@[192.168.1.2]>
In-Reply-To: <200112060417.XAA24928@makai.watson.ibm.com>
References: Message from rayson_ho@hongkong.com    of "Thu, 06 Dec 2001
 11:56:48 +0800." <gM988793884351.18059@mail1.hongkong.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 6 Dec 2001 08:07:41 -0500
To: David Edelsohn <dje@watson.ibm.com>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: fetch_and_add() available on PPC Linux?
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:17 PM -0500 12/5/01, David Edelsohn wrote:

>0:
>    lwarx   %1,0,%4         # oval = (*ptr) [linked]
>    add%I3  %2,%1,%3        # tmp = oval + val
>    stwcx.  %2,0,%4         # (*ptr) = tmp  [conditional]
>    bne-    0b              # if (store failed) retry

The only caveat is that the ptr to any two of these items must be in
individual lock granules. If the software has an array of locks that are
just a bunch of long-words, there's going to be difficultly. However, given
that this was an AIX box, and was probably a POWER machine, it's likely
that the POWER machine has the same lock granule restriction.

See the PPC manual for the lock granule size. I forget what it is off the
top of my head.

____________________________________________________________________
 Michael Zucca - mrz5149@acm.org
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
