From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Guillaume=20Laur=E8s?= <guillaume.laures@noos.fr>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: another endianness issue...
Date: Sun, 24 Jun 2001 16:50:42 +0200
Message-Id: <20010624145042.30340@smtp.wanadoo.fr>
In-Reply-To: <3B35F23B.5030003@noos.fr>
References: <3B35F23B.5030003@noos.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Is it correct ?
>And where can I find the cpu_to_le32() and le32_to_cpu() declaration or
>a guide on how to use them ?

If you use readl/writel, you don't need to byteswap as it's done for
you by those functions. If you used readb/writeb, then you are reading
bytes, swapping has no meaning.

Also, don't hard code 0x0002, better #define a constant, it makes the
code more readable.

cpu_to_le32/le32_to_cpu() are necessary if you are either not using
readx/writex accessors, or when storing datas in memory that the
controller will read directly (bus master)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
