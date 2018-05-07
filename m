Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fWJ93MNQzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 15:24:09 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w475O4B5080653
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 01:24:06 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2htbs20abx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 01:24:06 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 7 May 2018 06:24:00 +0100
Date: Mon, 7 May 2018 15:23:55 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/13] powerpc/eeh: Refactor report functions
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <313ced0e1c4f5140566846bb41f1c42c26c96a0b.1525242772.git.sbobroff@linux.ibm.com>
 <87efisamz3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
In-Reply-To: <87efisamz3.fsf@concordia.ellerman.id.au>
Message-Id: <20180507052354.GB18123@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 11:27:12PM +1000, Michael Ellerman wrote:
> Sam Bobroff <sbobroff@linux.ibm.com> writes:
> > diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh=
_driver.c
> > index eb4feee81ff4..1c4336dcf9f5 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -54,6 +54,25 @@ static int eeh_result_priority(enum pci_ers_result r=
esult)
> >  	}
> >  };
> > =20
> > +const char *pci_ers_result_name(enum pci_ers_result r)
> > +{
> > +	switch (r) {
> > +	case PCI_ERS_RESULT_NONE: return "none";
> > +	case PCI_ERS_RESULT_CAN_RECOVER: return "can recover";
> > +	case PCI_ERS_RESULT_NEED_RESET: return "need reset";
> > +	case PCI_ERS_RESULT_DISCONNECT: return "disconnect";
> > +	case PCI_ERS_RESULT_RECOVERED: return "recovered";
> > +	case PCI_ERS_RESULT_NO_AER_DRIVER: return "no AER driver";
> > +	default:
> > +		WARN_ONCE(1, "Unknown result type");
> > +		return "unknown";
> > +	}
> > +};
> > +
> > +#define eeh_infoline(EDEV, FMT, ...) \
> > +pr_info("EEH: PE#%x (PCI %s): " pr_fmt(FMT) "\n", EDEV->pe_config_addr=
, \
> > +((EDEV->pdev) ? dev_name(&EDEV->pdev->dev) : "NONE"), ##__VA_ARGS__)
>=20
> Ooof, I guess.
>=20
> It would be nicer as a function.

OK (I'd prefer to avoid macros too), but I'm not sure what kind of
function you mean. I initially tried to use a function, but the existing
pr_*() type macros seemed to be macros all the way down to printk, so there
didn't seem to be anywhere to hook into, and I ended up having to
open-code the varargs and allocate a buffer to print into.  Then it can
overflow etc. and it ended up seeming worse. Is there a better way I'm
missing here?

> "infoline" annoys me for some reason, "eeh_info" ?

OK. How about eeh_edev_info(), to indicate that it acts on an 'edev'?

> > @@ -223,123 +242,118 @@ static void eeh_set_irq_state(struct eeh_pe *ro=
ot, bool enable)
> >  				}
> >  }
> > =20
> > +static void eeh_pe_report(const char *name, struct eeh_pe *root,
> > +			  enum pci_ers_result (*fn)(struct eeh_dev *,
> > +						    struct pci_driver *),
> > +			  enum pci_ers_result *result)
> > +{
> > +	struct eeh_pe *pe;
> > +	struct eeh_dev *edev, *tmp;
> > +	enum pci_ers_result new_result;
> > +
> > +	pr_info("EEH: Beginning: '%s'\n", name);
> > +	eeh_for_each_pe(root, pe) {
> > +		eeh_pe_for_each_dev(pe, edev, tmp) {
>=20
> This should be in a separate function.

Oh, that's better. Will do!

> > +			device_lock(&edev->pdev->dev);
> > +			if (eeh_edev_actionable(edev)) {
> > +				struct pci_driver *driver;
> > +
> > +				driver =3D eeh_pcid_get(edev->pdev);
> > +
> > +				if (!driver)
> > +					eeh_infoline(edev, "no driver");
> > +				else if (!driver->err_handler)
> > +					eeh_infoline(edev,
> > +						     "driver not EEH aware");
> > +				else if (edev->mode & EEH_DEV_NO_HANDLER)
> > +					eeh_infoline(edev,
> > +						     "driver bound too late");
> > +				else {
> > +					new_result =3D fn(edev, driver);
> > +					eeh_infoline(edev,
> > +						"%s driver reports: '%s'",
> > +						driver->name,
> > +						pci_ers_result_name(new_result));
> > +					if (result)
> > +						*result =3D merge_result(*result,
> > +								       new_result);
> > +				}
> > +				if (driver)
> > +					eeh_pcid_put(edev->pdev);
> > +			} else {
> > +				eeh_infoline(edev, "not actionable (%d,%d,%d)",
> > +					     !!edev->pdev,
> > +					     !eeh_dev_removed(edev),
> > +					     !eeh_pe_passed(edev->pe));
> > +			}
> > +			device_unlock(&edev->pdev->dev);
>=20
> ^^^
>=20
>=20
> cheers

Thanks!

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlrv4uQACgkQMX8w6AQl
/iJ+OQf/VSCeT2xvGtMui2hX9NID6s1RUUIUOznhpZup9RX4/TAGI4jdizQsKLvN
dbpK20yWl2+FkbhwLDEJtPYD8Mc/Gf7aPLCtyzg1SddxOAfcgDA2XkDPK6gvij59
iXSmJgLxMPSSk7irupMRqt3KTeM8wscRT9jN3tJCLerXgU17CBlzK2sc+Mvmqn6O
ZU8rAyYIIAbEOu0NK0qI1o+GMN4Rmj0ExzgJHwN2AIjMlcRGYTEZEPNTj2Ed1XgP
6fMS8X+MEyEkUkPOqfoAut4CK7I6tRcxaBldPJAGcfGqNO+96DvJRV3D/szE1sFE
Z8flLepnusmCZhYGLH92WWKPsh3ACw==
=napr
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
