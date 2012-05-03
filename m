Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id D66F3B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 20:36:08 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 23284-07 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  3 May 2012 11:36:03 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/windfarm: don't pass const strings to snprintf
Date: Thu, 3 May 2012 11:35:48 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F05@saturn3.aculab.com>
In-Reply-To: <20120503161943.7d71d02e7d0aae6b9c0306bf@canb.auug.org.au>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> --- a/drivers/macintosh/windfarm_smu_sat.c
> +++ b/drivers/macintosh/windfarm_smu_sat.c
> @@ -287,7 +287,7 @@ static int wf_sat_probe(struct i2c_client *client,
>  		sens->sat =3D sat;
>  		sens->sens.ops =3D &wf_sat_ops;
>  		sens->sens.name =3D (char *) (sens + 1);
> -		snprintf(sens->sens.name, 16, "%s-%d", name, cpu);
> +		snprintf((char *)sens->sens.name, 16, "%s-%d",  name,
cpu);
> =20
>  		if (wf_register_sensor(&sens->sens))
>  			kfree(sens);

Wouldn't it be better to do:
		snprintf((char *)(sens + 1), 16, "%s-%d", name, cpu);

	David
