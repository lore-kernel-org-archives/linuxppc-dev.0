Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 887152C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 23:24:49 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 23556-10 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 17 Oct 2013 13:24:44 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] [PATCH] powerpc/vio: use strcpy in modalias_show
Date: Thu, 17 Oct 2013 13:22:26 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7393@saturn3.aculab.com>
In-Reply-To: <1382011211-15272-1-git-send-email-prarit@redhat.com>
References: <1382011211-15272-1-git-send-email-prarit@redhat.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Prarit Bhargava" <prarit@redhat.com>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: ben@decadent.org.uk, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Commit e82b89a6f19bae73fb064d1b3dd91fcefbb478f4 used strcat instead of
> strcpy which can result in an overflow of newlines on the buffer.
...
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1531,12 +1531,12 @@ static ssize_t modalias_show(struct device =
*dev, struct device_attribute
> *attr,
>=20
>  	dn =3D dev->of_node;
>  	if (!dn) {
> -		strcat(buf, "\n");
> +		strcpy(buf, "\n");
>  		return strlen(buf);
>  	}
>  	cp =3D of_get_property(dn, "compatible", NULL);
>  	if (!cp) {
> -		strcat(buf, "\n");
> +		strcpy(buf, "\n");
>  		return strlen(buf);
>  	}

Why not just:
		buf[0] =3D '\n';
		buf[1] =3D 0;
		return 1;

The assignment to buf[1] might not even be needed.

	David
