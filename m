Date: Thu, 30 Mar 2000 19:47:56 -0900
From: Ethan Benson <erbenson@alaska.net>
To: "Henry A. Worth" <haworth@ncal.verio.com>
Cc: linuxppc-dev@lists.linuxppc.org, haworth@verio.com
Subject: Re: LinuxPPC and Pismo Powerbook
Message-ID: <20000330194756.B688@plato.localdomain.local>
References: <200003302007.MAA07408@ shell1.ncal.verio.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <200003302007.MAA07408@ shell1.ncal.verio.com>; from haworth@ncal.verio.com on Thu, Mar 30, 2000 at 12:07:44PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2000 at 12:07:44PM -0800, Henry A. Worth wrote:

> A bit hard to boot off a root partition that doesn't exist, or
> a CD that doesn't support your machine. Any good installation
> is also going to have provisions for a rescue boot that doesn't
> depend upon any of the Linux partitions. With floppies going the
> way of the dodo, that usually means some form of boot partition.=20

yaboot will boot off ANY partition it knows how to read, including
HFS+ since it can just use OF's HFS+ support. you could boot a kernel
off your /home /var or /usr/local partition if you have them.  if you
have a macos partition i suggest dropping your kernel there and
booting it with yaboot.  this does not require the yaboot partition to
be macos readable. =20

> In my case I also needed a setup that would allow me to use
> MacOS to download test kernels until they worked reliably
> enough to do a full install.

again no need for a macos readable bootstrap partition, keep your
kernels and initial yaboot on the macos partition and OF boot them
directly.  in this case no matter what you are going to have to screw
with OF.  there is not reason to ensure that you have to screw with OF
permanatly by making a macos mountable bootstrap partition.

> I largely agree with you, but there are always alternative needs and
> solutions.=20

i have yet to see a compelling argument against the Apple_Bootstrap
partition type. =20

> Actually, ybin is probably a part of what I need, but I couldn't=20
> determine that from Ben's link or your webpage.=20

ybin will do nothing for you on macos, that should be clear to anyone
who bothers to read the web page.  i don't care about macos and am not
going to learn to program macos to make something for it.

> The macgzip I downloaded would not unzip it, and I've seen other=20
> complaints of the same. Probably not the latest version or IE
> munged the download, but most potential users are not going=20
> to spend their limited time debugging a tools packaging when they=20
> have no reason to believe that tool is going to help them. That's
> why enough seperate documentation is needed to know if this is
> a must have and to be able to plan how and when it will be used.

i fail to see how its my problem that people don't know how to
download a bloody file off the web without destroying it.   I also
have gotten exactly ZERO reports of this.  if people are having
problems they sure are not complaining very loudly.=20

just to make sure the file on the server is not damaged:

[eb@socrates eb]$ md5sum src/ybin-0.11.tar.gz
6c97abe1edd55dd9b2ef141c89a2e1a7  src/ybin-0.11.tar.gz
[eb@socrates eb]$ ssh www.linuxppc.org
eb@www.linuxppc.org's password:
[eb@www ybin]$ md5sum ybin-0.11.tar.gz
6c97abe1edd55dd9b2ef141c89a2e1a7  ybin-0.11.tar.gz
[eb@www ybin]$

[eb@socrates eb]$ wget http://www.linuxppc.org/ybin/ybin-0.11.tar.gz
--19:29:41--  http://www.linuxppc.org:80/ybin/ybin-0.11.tar.gz
           =3D> `ybin-0.11.tar.gz'
Connecting to www.linuxppc.org:80... connected!
HTTP request sent, awaiting response... 200 OK
Length: 22,400 [application/x-gunzip]

    0K -> .......... .......... . [100%]

19:29:46 (5.36 KB/s) - `ybin-0.11.tar.gz' saved [22400/22400]

[eb@socrates eb]$ md5sum ybin-0.11.tar.gz
6c97abe1edd55dd9b2ef141c89a2e1a7  ybin-0.11.tar.gz
[eb@socrates eb]$ md5sum src/ybin-0.11.tar.gz
6c97abe1edd55dd9b2ef141c89a2e1a7  src/ybin-0.11.tar.gz
[eb@socrates eb]$

[eb@socrates eb]$ wget http://www.alaska.net/~erbenson/ybin/ybin-0.11.tar.gz
--19:23:27--
http://www.alaska.net:80/%7Eerbenson/ybin/ybin-0.11.tar.gz
           =3D> `ybin-0.11.tar.gz'
Connecting to www.alaska.net:80... connected!
HTTP request sent, awaiting response... 200 OK
Length: 22,400 [application/x-tar]

    0K -> .......... .......... . [100%]

19:23:32 (4.83 KB/s) - `ybin-0.11.tar.gz' saved [22400/22400]

[eb@socrates eb]$ md5sum ybin-0.11.tar.gz
6c97abe1edd55dd9b2ef141c89a2e1a7  ybin-0.11.tar.gz
[eb@socrates eb]$

as you can see no matter how i get it i always get a matching md5sum
with my original copy.

just in case you don't trust md5s:

[eb@socrates eb]$ cp src/ybin-0.11.tar.gz.asc .
[eb@socrates eb]$ gpg --verify ybin-0.11.tar.gz.asc
gpg: Signature made Mon 13 Mar 2000 06:54:03 AM AKST using DSA key ID 2C447=
AFC
gpg: Good signature from "Ethan R. Benson <erbenson@alaska.net>"
[eb@socrates eb]$

my local copy of the GnuPG signature the linuxppc.com copy of ybin. =20

the file extracts just fine from linux, and just for good measure i
copied it to a floppy (the one downloaded from linuxppc.org) with
hfsutils and tried to extract it with Stuffit Expander 4.5 on my
powerbook 540c (running macos 8.1) it ungziped and untared it without
a single complaint, every file was perfectly intact.

I don't know what to tell, it looks to me like improperly downloaded
file, which will destroy your kernels just as well as a tarball.
maybe that is why you have problems booting your machine?

> Not at all, but there are limits to how much time I, or anyone else,
> is going spend downloading tools for MacOs to support a utility that

macos comes with stuffit expander which extracts tarballs just fine.
if it doesn't then there was a problem downloading, which would
destroy your kernels just as well as a tarball.  again i fail to see
how this is my problem. =20

> they had not been convinced would be of use. I'm not interested in
> MacOS or downloading a bunch of tools that I would only use once.
> If it wasn't for DVD's, MacOS would have already been flushed from=20

DeCSS, it removes cascading style sheets from web pages ;-)

> my system as soon as I didn't need it to download kernels for testing.
>=20
> That's good news and badly needed, the two putative end-user=20
> distributions have dropped the ball here. Since they are
> the ones trying to make a buck pushing this on end users, I=20
> view them as having the ultimate responsibility to throughly
> document this stuff. With SUSE getting involved and some signs
> that Mandrake is interested in PPC, there is hope for=20
> improvement in that arena.

debian's installation will take care of creating this bootstrap
partition and probably setup yaboot as part of the installtion.

> But any comprehensive document needs to cover all the options
> and their pros and cons. Make your recommendations, but don't
> forget that other users have different needs and biases. And=20

i will mention that the bootstrap partition CAN but should not be a
regular HFS partition for the reasons i have stated.  but i am not
going to obfuscate the docs with lots of info about methods i have
found DO NOT WORK RELIABLY.

> please make the document available seperate from your package=20
> in plain text, HTML, or pdf. Wish I could help you, this is

they are man pages, they will be posted to the internet in HTML format
and available in the distribution in nroff and probably HTML as well.

> badly needed, but until a few weeks ago I hadn't touched a=20
> Mac in nearly a decade, and only have all the conflicting=20
> opinions and facts I could glean, largely from these mailists,
> to go by. I'd be happy to review your document if you'd like.
>=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjjkLfsACgkQJKx7GixEevwYwgCeJYQUZ/YImZxqlDyqUQ2B/V45
sFcAn2xnuysxztmNIDDylJto5+CLi5RS
=k7M8
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
