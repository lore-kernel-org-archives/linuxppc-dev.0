Message-Id: <200112060417.XAA24928@makai.watson.ibm.com>
To: rayson_ho@hongkong.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: fetch_and_add() available on PPC Linux? 
In-Reply-To: Message from rayson_ho@hongkong.com
   of "Thu, 06 Dec 2001 11:56:48 +0800." <gM988793884351.18059@mail1.hongkong.com>
Date: Wed, 05 Dec 2001 23:17:29 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Have you looked at the atomicity macros for PowerPC in glibc?  You
want to use the load-linked store-conditional instructions.  Something
along the lines of:

0:
    lwarx   %1,0,%4         # oval = (*ptr) [linked]
    add%I3  %2,%1,%3        # tmp = oval + val
    stwcx.  %2,0,%4         # (*ptr) = tmp  [conditional]
    bne-    0b              # if (store failed) retry

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
