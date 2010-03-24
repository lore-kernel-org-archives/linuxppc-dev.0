Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 69209B7CBB
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 23:05:38 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 8so1633884qwh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Mar 2010 05:05:36 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 24 Mar 2010 07:05:15 -0500
Message-ID: <ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 24, 2010 at 1:07 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:

>> +- fsl,firmware-phandle:
>> + =A0 =A0Usage: required
>> + =A0 =A0Value type: <phandle>
>> + =A0 =A0Definition: Points to a firmware node (see "QE Firmware Node" b=
elow)
>> + =A0 =A0 =A0 =A0that contains the firmware that should be uploaded for =
this QE.
>> + =A0 =A0 =A0 =A0The compatible property for the firmware node should sa=
y,
>> + =A0 =A0 =A0 =A0"fsl,qe-firmware".
>> +
>
> Why the phandle redirection? =A0Why not just put the firmware blob into
> a property in the QE node, or as a subnode?

Because there might be multiple QE devices on a single chip, and each
will need to upload the same firmware.  So instead of embedding the
firmware multiple times, just embed it once, and have a pointer.

I could expand the binding to say that a node should look for either
fsl,firmware-phandle *or* a child fsl,qe-firmware node, but I think
that overly complicates things.  It also makes it more complicated for
the boot loader to create the fsl,qe-firmware node, since it has to
figure out where to put that node.  I can imaging a situation where
the DTS has the fsl,firmware-phandle properties and an empty
fsl,qe-firmware node at the root, and the boot loader just fills it
in.

--=20
Timur Tabi
Linux kernel developer at Freescale
