Return-Path: <adilger@dilger.ca>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsptZ5rQZzF1b3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 10:44:18 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id x1so1292576pfh.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Mar 2018 15:44:18 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <FCCCD016-8402-42E5-B92F-79287D67B27C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9B87DCCE-81B6-4AB2-A810-550E560575CD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC 1/5] seq_file: introduce seq_open_data helper
Date: Thu, 1 Mar 2018 16:44:10 -0700
In-Reply-To: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_9B87DCCE-81B6-4AB2-A810-550E560575CD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 1, 2018, at 4:37 PM, Rasmus Villemoes <linux@rasmusvillemoes.dk> =
wrote:
>=20
> There are quite a few callers of seq_open that could be simplified by
> setting the ->private member via the seq_open call instead of fetching
> file->private_data afterwards.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> I've just included a few examples of possible users of this helper,
> there are many more similar cases. As a bonus, the first two fix
> potential NULL derefs (if one believes that seq_open can actually
> fail).
>=20
> seq_open_private would have been a better name, but that one is
> already taken...
>=20
> Documentation/filesystems/seq_file.txt | 9 +++++----
> fs/seq_file.c                          | 9 ++++++++-
> include/linux/seq_file.h               | 1 +
> 3 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/filesystems/seq_file.txt =
b/Documentation/filesystems/seq_file.txt
> index 9de4303201e1..68571b8275d8 100644
> --- a/Documentation/filesystems/seq_file.txt
> +++ b/Documentation/filesystems/seq_file.txt
> @@ -234,10 +234,11 @@ Here, the call to seq_open() takes the =
seq_operations structure we created
> before, and gets set up to iterate through the virtual file.
>=20
> On a successful open, seq_open() stores the struct seq_file pointer in
> -file->private_data. If you have an application where the same =
iterator can
> -be used for more than one file, you can store an arbitrary pointer in =
the
> -private field of the seq_file structure; that value can then be =
retrieved
> -by the iterator functions.
> +file->private_data. If you have an application where the same =
iterator
> +can be used for more than one file, you can store an arbitrary =
pointer
> +in the private field of the seq_file structure; that value can then =
be
> +retrieved by the iterator functions. Using the wrapper =
seq_open_data()
> +allows you to set the initial value for that field.
>=20
> There is also a wrapper function to seq_open() called =
seq_open_private(). It
> kmallocs a zero filled block of memory and stores a pointer to it in =
the
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index eea09f6d8830..f2145cb6e23d 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -45,7 +45,7 @@ static void *seq_buf_alloc(unsigned long size)
>  *	Note: seq_open() will allocate a struct seq_file and store its
>  *	pointer in @file->private_data. This pointer should not be =
modified.
>  */
> -int seq_open(struct file *file, const struct seq_operations *op)
> +int seq_open_data(struct file *file, const struct seq_operations *op, =
void *data)
> {
> 	struct seq_file *p;
>=20
> @@ -59,6 +59,7 @@ int seq_open(struct file *file, const struct =
seq_operations *op)
>=20
> 	mutex_init(&p->lock);
> 	p->op =3D op;
> +	p->private =3D data;
>=20
> 	// No refcounting: the lifetime of 'p' is constrained
> 	// to the lifetime of the file.
> @@ -85,6 +86,12 @@ int seq_open(struct file *file, const struct =
seq_operations *op)
> }
> EXPORT_SYMBOL(seq_open);
>=20
> +int seq_open(struct file *file, const struct seq_operations *op)
> +{
> +	return seq_open_data(file, op, NULL);
> +}
> +EXPORT_SYMBOL(seq_open_data);

This is a bit confusing.  You export "seq_open" after seq_open_data(),
and export "seq_open_data" here after seq_open().  Not strictly a bug,
but could become one in the future.

Cheers, Andreas

> +
> static int traverse(struct seq_file *m, loff_t offset)
> {
> 	loff_t pos =3D 0, index;
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index ab437dd2e3b9..f5ff376fa62b 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -107,6 +107,7 @@ void seq_pad(struct seq_file *m, char c);
>=20
> char *mangle_path(char *s, const char *p, const char *esc);
> int seq_open(struct file *, const struct seq_operations *);
> +int seq_open_data(struct file *, const struct seq_operations *, void =
*);
> ssize_t seq_read(struct file *, char __user *, size_t, loff_t *);
> loff_t seq_lseek(struct file *, loff_t, int);
> int seq_release(struct inode *, struct file *);
> --
> 2.15.1
>=20





--Apple-Mail=_9B87DCCE-81B6-4AB2-A810-550E560575CD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlqYkEsACgkQcqXauRfM
H+AzdQ//S1/2JezuOJUxxbNc11QjDvMOoBPM7D11h6Ht5dT0+Tw0dFBFBcG+gqGl
28MxwK+4sUU3A00/LgUxopfeoKw6+ve4NZFZYh0kwZoEXMoCxkB2tECNRYMrkiDR
TDY70i4VZ5Bch1xd31FB3bZb+ukkls1R0Z/6WjfUhG8D/5yPBA9PQS0+jHo+tHHX
y4aJS9eCwKPRHtP5LpCkuaEKZFxL48RWFghHcqhfd8fXRuFD9Q6/mPhLkH3/fX4y
IsbUFW2ozrN94/3OWM+1+4r8eC1mpe+DqRkqg/4G0CX6agfpmpkUh++8QGP6fufV
RG5pAaMwEpqXsFygvwvWFJEkeLp1BFybgmGKe3gN9A7arlyhxhW8J+8FbPBpduq4
T/Okk/qcJhSMVV/at9sybRKMvZ40IX0E5jRwmPG/AQl1Bsj/yyOTmJCTHAowIydx
VkYxTsmSPjnVm2LPELBCEPUqT5jDgpFDBzr148l6ks6Q1Vxiw0MJZL+zruRtOfcC
wHa05O5AZjwRXpk8LBWE48x2qroLjM5Oruqkjg53DX7LgHUxRwhY4li7gGnfxmTf
gZl526gU0fx6xPsiV6F6sLazf91BmmUi0x12n4nJMjESLMJP4OrRkhgNtiM1uK/m
cp/UMSnVXC0ks7HiE8CP08WcFoho6LoazlgEXHawk4Y/+fRwWy8=
=E59S
-----END PGP SIGNATURE-----

--Apple-Mail=_9B87DCCE-81B6-4AB2-A810-550E560575CD--
