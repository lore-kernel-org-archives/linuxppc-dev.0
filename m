In-Reply-To: <38DA42E5.2B80E717@ncal.verio.com>
Date: Thu, 23 Mar 2000 17:44:16 +0100
To: Henry Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PB2000 (pismo) install feedback
Message-Id: <20000323174416.031445@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 23, 2000, Henry Worth <haworth@ncal.verio.com> wrote:

>It's very timing sensitive, a slight rearrangment of the code eliminated
>the "burnout", but didn't fix the ongoing offb colormap problems. Adding
>a small delay between writing the index and the palette value fixed the
>colomap problem. I rearranged the code to just set the index once and
>then use the palette index register's auto-incrementing to avoid the
>index write and delay in the loop, and that worked as well. I think
>Ben is planning to use a read back of the index register to ensure the
>write is posted and and give enough of a delay.
>
>Does anyone know if any of the ATI chips don't have autoincrementing of
>the palette index? That's been a fairly standard feature of RAMDAC's
>for a long time. So I was a bit surprised to see the frame buffers
>explicitly setting the index on every iteration, especially since
>the race between writing the palette index and the data has been
>a common problem for a long time.

What bugs me is that we have no such delay in aty128fb.c and you didn't
see the problem occur. Looks like a 1 instruction timing (one eieio) is
enough, so I beleive reading back the index is enough. We didn't have
this problem with older r128, so this may be a side effect of the
swadowing of the 2 sets of palette registers in the M3.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
