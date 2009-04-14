Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: devicetree-discuss@ozlabs.org
Subject: Re: [PATCH 1/4 v2] mtd: physmap_of: Add multiple regions and
	concatenation support
Date: Tue, 14 Apr 2009 14:57:06 +0200
References: <1239093559-12043-1-git-send-email-sr@denx.de>
	<fa686aa40904112258n1cc23b48t80b135b7016e9760@mail.gmail.com>
In-Reply-To: <fa686aa40904112258n1cc23b48t80b135b7016e9760@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904141457.06664.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 12 April 2009, Grant Likely wrote:
> > + =A0 =A0 =A0 info =3D kzalloc(sizeof(struct of_flash) +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct of_flash_lis=
t) * count, GFP_KERNEL);
> > + =A0 =A0 =A0 if (!info)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> > +
> > + =A0 =A0 =A0 mtd_list =3D kzalloc(sizeof(struct mtd_info) * count, GFP=
_KERNEL);
>
> Typically I prefer to see a single kzalloc in a driver which allocates
> all the space needed in one go because it simplifies the error/unwind
> path.

In general ack, but it doesn't make much sense in this case. The 2nd malloc=
 is=20
for an temporary buffer needed for mtd_concat_create() call (list of struct=
=20
mtd_info. I can't really combine those two areas. So I'll leave this=20
untouched.

Best regards,
Stefan
