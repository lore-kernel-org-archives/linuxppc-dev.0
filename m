From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Wozniak <adam.wozniak@comdev.cc>
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: crash in fault.c
Date: Mon, 1 Oct 2001 21:37:53 +0200
Message-Id: <20011001193753.838@smtp.adsl.oleane.com>
In-Reply-To: <3BB8B3AC.3A97D7D@comdev.cc>
References: <3BB8B3AC.3A97D7D@comdev.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>(apologies for the previous blank message)
>
>I get this randomly and frequently, usually when booting, attempting to
>ftp
>to the box, or occasionally when starting a new process.
>
>Any hints or clues are appreciated.
>
>I'm using kernel 2.4.4 running on a custom 8260 based board.

Does the 8260 have BATs ?

If not, can you check if the code for ret_from_except is entirely
contained in a single page or spans over 2 pages ?
(objdump should help here).

If it is the case, then you need some of my fixes to make the exception
return path safe against TLB misses (or hash misses, dunno if you have
a hash table on this CPU).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
