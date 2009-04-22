Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id 145FDDE0B9
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 01:57:29 +1000 (EST)
Received: by bwz19 with SMTP id 19so50354bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 08:57:27 -0700 (PDT)
MIME-Version: 1.0
Sender: ricardo.ribalda@gmail.com
In-Reply-To: <874owhoxce.fsf@macbook.be.48ers.dk>
References: <1240387541-16594-1-git-send-email-ricardo.ribalda@uam.es>
	<874owhoxce.fsf@macbook.be.48ers.dk>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Date: Wed, 22 Apr 2009 17:34:29 +0200
Message-ID: <aa76a2be0904220834x48fe3d97i1086595f1fd63701@mail.gmail.com>
Subject: Re: [MTD] ofpart: Partitions at same address cannot have the same
	name
To: Peter Korsgaard <jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David.Woodhouse@intel.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello

You are right, remove the -1. I thought that strlen gives the #of
chars + 1 ('\0').


  Thanks



On Wed, Apr 22, 2009 at 11:24, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>>>>> "Ricardo" =3D=3D Ricardo Ribalda Delgado <ricardo.ribalda@uam.es> wr=
ites:
>
> Hi,
>
> =A0Ricardo> Sometimes, an special partition is included in the device
> =A0Ricardo> tree including all the partitions. Like in:
>
> =A0Ricardo> =A0drivers/mtd/ofpart.c | =A0 =A03 ++-
> =A0Ricardo> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> =A0Ricardo> diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
> =A0Ricardo> index 3e164f0..0af3b07 100644
> =A0Ricardo> --- a/drivers/mtd/ofpart.c
> =A0Ricardo> +++ b/drivers/mtd/ofpart.c
> =A0Ricardo> @@ -48,7 +48,8 @@ int __devinit of_mtd_parse_partitions(struc=
t device *dev,
>
> =A0Ricardo> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if this is a partition n=
ode */
> =A0Ricardo> =A0 =A0 =A0 =A0 =A0 =A0 =A0 partname =3D of_get_property(pp, =
"name", &len);
> =A0Ricardo> - =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(partname, "partition") !=
=3D 0) {
> =A0Ricardo> + =A0 =A0 =A0 =A0 =A0 =A0 if (strncmp(partname, "partition", =
strlen("partition")-1)
>
> Why strlen() - 1 ?
>
> --
> Bye, Peter Korsgaard
>



--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
