Return-Path: <pku.leo@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420Nj82Kv8zF0PW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 08:29:31 +1000 (AEST)
Received: by mail-it0-f66.google.com with SMTP id h3-v6so4972585ita.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 15:29:31 -0700 (PDT)
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com.
 [209.85.223.182])
 by smtp.gmail.com with ESMTPSA id 14-v6sm1260107itu.20.2018.08.28.15.29.27
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Aug 2018 15:29:28 -0700 (PDT)
Received: by mail-io0-f182.google.com with SMTP id w11-v6so2848536iob.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 15:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
 <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
 <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
In-Reply-To: <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 28 Aug 2018 17:29:15 -0500
Message-ID: <CADRPPNSoP5K79wCr5QdJ-OR_W9aZrEkBiPqCXU7EWCfZsvaeuQ@mail.gmail.com>
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
To: tyreld@linux.vnet.ibm.com
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, David Brown <david.brown@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Zhao Qiang <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2018 at 5:16 PM Tyrel Datwyler
<tyreld@linux.vnet.ibm.com> wrote:
>
> On 08/28/2018 11:48 AM, Li Yang wrote:
> > On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> In preparation to remove the node name pointer from struct device_node,
> >> convert printf users to use the %pOFn format specifier.
> >
> > Please forgive my ignorance, but what is this format specifier do
> > exactly?   I cannot find anything listed in the printf specification
> > matching this.  Is this something newly introduced?
> >
> > Leo
> >
>
> From Documentation/core-api/printk-formats.rst:

I was trying to find it in the standard c format specifier.  :(
Thanks a lot for the pointer.

>
> kobjects
> --------
>
> ::
>
>         %pOF[fnpPcCF]
>
>
> For printing kobject based structs (device nodes). Default behaviour is
> equivalent to %pOFf.
>
>         - f - device node full_name
>         - n - device node name
>         - p - device node phandle
>         - P - device node path spec (name + @unit)
>         - F - device node flags
>         - c - major compatible string
>         - C - full compatible string
>
>
> -Tyrel
>
