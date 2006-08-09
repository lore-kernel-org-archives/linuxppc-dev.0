Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF94F67B54
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 23:17:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k79DHdC6003547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 09:17:39 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k79DHdwa199996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 09:17:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k79DHcuk027502
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 09:17:39 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] ehea: header files
Date: Wed, 9 Aug 2006 15:17:36 +0200
References: <44D99F56.7010201@de.ibm.com>
In-Reply-To: <44D99F56.7010201@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608091517.37379.arnd.bergmann@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 August 2006 10:39, Jan-Bernd Themann wrote:
> +extern int ehea_trace_level;
> +
> +#ifdef EHEA_NO_EDEB
> +#define EDEB_P_GENERIC(level, idstring, format, args...) \
> +=A0=A0=A0=A0=A0=A0=A0while (0 =3D=3D 1) { \
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0if(unlikely (level <=3D ehea_trace_level)) =
{ \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pri=
ntk("%s " idstring " "format "\n", \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0__func__, ##args); \
> +=A0=A0=A0=A0=A0=A0=A0 =A0} \
> +=A0=A0=A0=A0=A0=A0=A0} \
> +
> +#else
> +
> +#define EDEB_P_GENERIC(level,idstring,format,args...) \
> +if (level < KEEP_EDEBS_BELOW) { \
> +=A0=A0=A0=A0=A0=A0=A0do { \
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0if(unlikely (level <=3D ehea_trace_level)) =
{ \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pri=
ntk("%s " idstring " "format "\n", \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0__func__, ##args); \
> +=A0=A0=A0=A0=A0=A0=A0 =A0} \
> +=A0=A0=A0=A0=A0=A0=A0} while (1 =3D=3D 0); \
> +}
> +#endif
> +
> +#define EDEB(level, format, args...) \
> + =A0 =A0 =A0 =A0EDEB_P_GENERIC(level, "", format, ##args)
> +
> +#define EDEB_ERR(level, format, args...) \
> + =A0 =A0 =A0 =A0EDEB_P_GENERIC(level, "EHEA_ERROR", format, ##args)
> +
> +#define EDEB_EN(level, format, args...) \
> + =A0 =A0 =A0 =A0EDEB_P_GENERIC(level, ">>>", format, ##args)
> +
> +#define EDEB_EX(level, format, args...) \
> + =A0 =A0 =A0 =A0EDEB_P_GENERIC(level, "<<<", format, ##args)

Please don't invent your own debugging macros. You can either use the
pr_debug/pr_info facility from <linux/kernel.h> or get rid of those
completely. The latter is probably preferred for most of your calls.

	Arnd <><
