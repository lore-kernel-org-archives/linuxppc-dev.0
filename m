Date: Sun, 30 Sep 2001 12:22:11 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Jan Nieuwenhuizen <janneke@gnu.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10-ben0 doesn't see ide1
Message-Id: <20010930122211.2cf9b2f7.jpgarcia@execpc.com>
In-Reply-To: <m3adzddmfh.fsf@appel.lilypond.org>
References: <m3adzddmfh.fsf@appel.lilypond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 30 Sep 2001 12:04:34 +0200
Jan Nieuwenhuizen <janneke@gnu.org> wrote:

>
> Hi,
>
> Yesterday's 2.4.10-ben0 (Sat Sep 29 23:32:51 CEST 2001) kernel doesn't
> see my ide1 device.  Previous kernels had no problems.  There's an
>
>     ide-pmac(ide): can't request IO resource

Rack this up as an OF bug on some systems I think.  I got it too (Wallstreet2/300).  The OF IDE nodes request what look like twice memory as much as they need.  Linux doesn't even use most of it anyway.

The two ide busses in my system have resources 0x10000 apart, while they both reserve a size of 0x20000 (IIRC).  Since BenH's recent kernels reserve space based on OF, and then request it realistically, in this situation, it will fail on half of the resource allocation.  Even though we don't use the overlapping area...

Quick fix? halve all the resource sizes of the ide nodes. (DMA's space also does this).  I don't know what the long term fix would be.

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
