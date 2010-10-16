Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4CB3689F.1050601@fusionio.com>
References: <20101011191335.GH5851@bicker>
	<4CB3689F.1050601@fusionio.com>
Date: Sat, 16 Oct 2010 21:39:43 +0200
Message-ID: <AANLkTi=wQDgAHC0Zm+psdP2g+B7JZJ8ot1NPCE+AAqU0@mail.gmail.com>
Subject: Re: [patch] ps3disk: passing wrong variable to bvec_kunmap_irq()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jens Axboe <jaxboe@fusionio.com>
Content-Type: text/plain; charset=UTF-8
Cc: "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
	Dan Carpenter <error27@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Geoff Levand <geoff@infradead.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 11, 2010 at 21:42, Jens Axboe <jaxboe@fusionio.com> wrote:
> On 2010-10-11 21:13, Dan Carpenter wrote:
>> This should pass "buf" to bvec_kunmap_irq() instead of "bv". =C2=A0The a=
pi is
>> like kmap_atomic() instead of kmap().
>>
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
>>
>> diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
>> index e9da874..03688c2 100644
>> --- a/drivers/block/ps3disk.c
>> +++ b/drivers/block/ps3disk.c
>> @@ -113,7 +113,7 @@ static void ps3disk_scatter_gather(struct ps3_storag=
e_device *dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 memcpy(buf, dev->bounce_buf+offset, size);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset +=3D size;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_kernel_dcache_pag=
e(bvec->bv_page);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bvec_kunmap_irq(bvec, &flags=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bvec_kunmap_irq(buf, &flags)=
;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0}
>
> Thanks applied, that bug is all too common.

Because  bvec_kunmap_irq() is a macro if !CONFIG_HIGHMEM, and thus there's =
no
argument type checking on e.g. pp64, which doesn't support HIGHMEM?

What about turning it into an inline function?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
