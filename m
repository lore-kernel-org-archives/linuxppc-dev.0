Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 3 Apr 2007 18:44:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] cbe_cpufreq.c initialisation
Message-Id: <20070403184445.49053b4f.sfr@canb.auug.org.au>
In-Reply-To: <1175589451.30879.14.camel@localhost.localdomain>
References: <20070403182037.93221d65.sfr@canb.auug.org.au>
	<1175589451.30879.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Apr_2007_18_44_45_+1000_=kbcHR4cuDYMg483"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Apr_2007_18_44_45_+1000_=kbcHR4cuDYMg483
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 03 Apr 2007 18:37:31 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Tue, 2007-04-03 at 18:20 +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > In cbe_cpufreq_cpu_init, there is this code:
> >
> > 	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
> >         // we need the freq in kHz
> >         *max_freq /= 1000;
> >
> > does this really need to modify the property value in place?
>
> No, that's obviously a bug...

Excellent, because that was the last non-const usage of get_property in
the whole tree :-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Apr_2007_18_44_45_+1000_=kbcHR4cuDYMg483
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGEhQDFdBgD/zoJvwRAhbUAJ91H1btN3JMvondqDB1jJRXQRwyBgCfb4e7
JQCp7lo1ckQEID9dDWnuRRM=
=Lgi/
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Apr_2007_18_44_45_+1000_=kbcHR4cuDYMg483--
