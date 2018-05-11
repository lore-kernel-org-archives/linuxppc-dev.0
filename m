Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hz1y5qxvzF1dM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:20:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alastair D'Silva <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, arnd@arndb.de, linux-doc@vger.kernel.org,
 malat@debian.org, gregkh@linuxfoundation.org, corbet@lwn.net,
 vaibhav@linux.vnet.ibm.com, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 fbarrat@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, pombredanne@nexb.com, felix@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v4 6/7] ocxl: Add an IOCTL so userspace knows what OCXL
 features are available
In-Reply-To: <20180509053506.9754-7-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com>
 <20180509053506.9754-1-alastair@au1.ibm.com>
 <20180509053506.9754-7-alastair@au1.ibm.com>
Date: Fri, 11 May 2018 15:20:21 +1000
Message-ID: <871seisr8q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Alastair D'Silva" <alastair@au1.ibm.com> writes:

> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 8d2748e69c84..bb80f294b429 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -72,5 +75,6 @@ struct ocxl_ioctl_irq_fd {
>  #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_i=
rq_fd)
>  #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl=
_metadata)
>  #define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioc=
tl_p9_wait)
> +#define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl=
_platform)

I don't have ocxl_ioctl_platform ?

../include/uapi/misc/ocxl.h:78:56: error: invalid application of =E2=80=98s=
izeof=E2=80=99 to incomplete type =E2=80=98struct ocxl_ioctl_platform=E2=80=
=99
 #define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_p=
latform)
                                                        ^
../include/uapi/asm-generic/ioctl.h:73:5: note: in definition of macro =E2=
=80=98_IOC=E2=80=99
   ((size) << _IOC_SIZESHIFT))
     ^~~~
../include/uapi/asm-generic/ioctl.h:86:56: note: in expansion of macro =E2=
=80=98_IOC_TYPECHECK=E2=80=99
 #define _IOR(type,nr,size) _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size=
)))
                                                        ^~~~~~~~~~~~~~
../include/uapi/misc/ocxl.h:78:33: note: in expansion of macro =E2=80=98_IO=
R=E2=80=99
 #define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_p=
latform)
                                 ^~~~
../drivers/misc/ocxl/file.c:262:7: note: in expansion of macro =E2=80=98OCX=
L_IOCTL_GET_FEATURES=E2=80=99
  case OCXL_IOCTL_GET_FEATURES:
       ^~~~~~~~~~~~~~~~~~~~~~~

cheers
