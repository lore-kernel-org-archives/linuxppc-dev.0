From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>
Subject: Re: tlbia and PPC603
Date: Wed, 19 Jun 2002 05:51:37 +0200
Message-Id: <20020619035137.12068@smtp.wanadoo.fr>
In-Reply-To: <20020620150906H.ekato@ees.hokudai.ac.jp>
References: <20020620150906H.ekato@ees.hokudai.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I also tested your latest rsync tree.  With the same test, the kernel
>also dropped to xmon 8 times, and worked stable 2 times.
>
>
>Even the situation have improved with isync, I'm becoming not sure
>about _tlbia is the problem.  Does anyone know other things causing
>problem on PPC603 Macintosh??
>
>I tested this on UMAX C500 (144M RAM, 240MHz 603ev, DEC21140 ether card).

Try without the ethernet card and switch IDE DMA off and tell me if it is
stable, there could be some cache coherency issues with some of the chipsets
used on these machines.

Another thing you can try is in set_context(), add an isync on the line
that contain the label "3:" as the doc states a context synchronizing
instruction should also be used for data sync. before mtsrin.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
