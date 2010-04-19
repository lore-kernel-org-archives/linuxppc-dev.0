Return-Path: <pku.leo@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 5AC9CB7D08
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Apr 2010 16:23:12 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so1374943qwi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Apr 2010 23:23:10 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1271644449.14835.35.camel@concordia>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
	<1271403278-30091-2-git-send-email-leoli@freescale.com>
	<1271403278-30091-3-git-send-email-leoli@freescale.com>
	<1271644449.14835.35.camel@concordia>
Date: Mon, 19 Apr 2010 14:23:10 +0800
Message-ID: <z2n2a27d3731004182323k3ed2869ayf1bd5cdb486edb89@mail.gmail.com>
Subject: Re: [PATCH 3/4] fsl_msi: enable msi sharing through AMP OSes
From: Li Yang <leoli@freescale.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 19, 2010 at 10:34 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Fri, 2010-04-16 at 15:34 +0800, Li Yang wrote:
>> From: Zhao Chenhui <b26998@freescale.com>
>>
>> Make a single PCIe MSI bank shareable through CAMP OSes. The number of
>> MSI used by each core can be configured by dts file.
>>
>> Signed-off-by: Zhao Chenhui <b26998@freescale.com>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> =C2=A0arch/powerpc/sysdev/fsl_msi.c =C2=A0 =C2=A0| =C2=A0 =C2=A08 ++++++=
+-
>> =C2=A0arch/powerpc/sysdev/msi_bitmap.c | =C2=A0 =C2=A04 ++--
>> =C2=A02 files changed, 9 insertions(+), 3 deletions(-)
> ..
>> diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_=
bitmap.c
>> index 5a32cbe..b41db96 100644
>> --- a/arch/powerpc/sysdev/msi_bitmap.c
>> +++ b/arch/powerpc/sysdev/msi_bitmap.c
>> @@ -95,8 +95,8 @@ int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bm=
p)
>> =C2=A0 =C2=A0 =C2=A0 /* Format is: (<u32 start> <u32 count>)+ */
>> =C2=A0 =C2=A0 =C2=A0 len /=3D 2 * sizeof(u32);
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < len; i++, p +=3D 2) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j < *(p + 1); =
j++)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
bitmap_release_region(bmp->bitmap, *p + j, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D *p; j < *(p + 1);=
 j++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
bitmap_release_region(bmp->bitmap, j, 0);
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 spin_unlock(&bmp->lock);
>
> This looks like a bug fix to the msi bitmap code, is it not? Please
> split it into a separate commit with an explanatory changelog.

Oops.  We thought the property to be {start end} by mistake.  The
change shouldn't be needed.

Thanks,
Leo
