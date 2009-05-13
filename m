Return-Path: <pku.leo@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id AE54EDDFC1
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 20:57:31 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so269052ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 03:57:29 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1242119872.16400.113.camel@demuxf9c>
References: <1242119872.16400.113.camel@demuxf9c>
Date: Wed, 13 May 2009 18:57:28 +0800
Message-ID: <2a27d3730905130357re0adf41l19f5603a70dac57b@mail.gmail.com>
Subject: Re: RapidIO - general questions
From: Li Yang <leoli@freescale.com>
To: Jan Neskudla <jan.neskudla.ext@nsn.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cc'ed LKML

On Tue, May 12, 2009 at 5:17 PM, Jan Neskudla <jan.neskudla.ext@nsn.com> wr=
ote:
> Hallo
>
> we'd likes to use a RapidIO as a general communication bus on our new
> product, and so I have some questions about general design of Linux RIO
> subsystem. I did not find any better mailing list for RapidIO
> discussion.
>
> [1] - we'd like to implement following features
> =C2=A0 =C2=A0* Hot-plug (hot-insert/hot-remove) of devices
> =C2=A0 =C2=A0* Error handling (port-write packets - configuration, handli=
ng of
> them)
> =C2=A0 =C2=A0* Static ID configuration based on port numbers
> =C2=A0 =C2=A0* Aux driver - basic driver, for sending messages over diffe=
rent
> mboxes, handling ranges of doorbells
>
> =C2=A0 =C2=A0Is it here anyone who is working on any improvement, or anyo=
ne who
> knows the development plans for RapidIO subsystem?
>

AFAIK, there is no one currently working on these features for Linux.
It will be good if you can add these useful features.

> [2] - I have a following problem with a current implementation of
> loading drivers. The driver probe-function call is based on comparison
> of VendorID (VID) and DeviceID (DID) only. Thus if I have 3 devices with
> same DID and VID connected to the same network (bus), the driver is
> loaded 3times, instead only once for the actual device Master port.

This should be the correct way as you actually have 3 instances of the devi=
ce.

>
> Rionet driver solved this by enabling to call initialization function
> just once, and it expect that this is the Master port.

Rionet is kind of special.  It's not working like a simple device
driver, but more like a customized protocol stack to support multiple
ethernet over rio links.

>
> Is it this correct behavior =C2=A0? It looks to me that RapidIO is handle=
d
> like a local bus (like PCI)

This is correct behavior.  All of them are using Linux device/driver
infrastructure, but rionet is a special device.

- Leo
