Return-Path: <rbrito@ime.usp.br>
Received: from hope.ime.usp.br (hope.ime.usp.br [143.107.45.8])
	by ozlabs.org (Postfix) with SMTP id 72EE0DDDE1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 18:19:39 +1100 (EST)
Date: Tue, 21 Oct 2008 05:19:24 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [REGRESSION 2.6.27] i2c-mpc not probing on linkstation
Message-ID: <20081021071924.GB15748@ime.usp.br>
References: <20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
	<9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
	<Pine.LNX.4.64.0810192347250.21665@axis700.grange>
	<9e4733910810191505u3ec1db0dl25e87bf3b78c740d@mail.gmail.com>
	<Pine.LNX.4.64.0810200022040.21665@axis700.grange>
	<9e4733910810191540p1000c28l89ca50794addae37@mail.gmail.com>
	<Pine.LNX.4.64.0810200754550.3941@axis700.grange>
	<9e4733910810200519w4689131dv73bf3539c53d2bea@mail.gmail.com>
	<Pine.LNX.4.64.0810210832260.4941@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.64.0810210832260.4941@axis700.grange>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Oct 21 2008, Guennadi Liakhovetski wrote:
> On Mon, 20 Oct 2008, Jon Smirl wrote:
> > Put a printk in it's init function to make sure it is initializing.
> 
> I don't need that, I see it here:
> 
> /sys/bus/of_platform/drivers/mpc-i2c

I also see this:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
lutz:/# tree /sys/bus/of_platform/drivers/mpc-i2c/
/sys/bus/of_platform/drivers/mpc-i2c/
|-- bind
|-- uevent
`-- unbind

0 directories, 3 files
lutz:/#
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> > Next thing I do is put printks over in arch/powerpc/.. to tell me
> > which strings from the device tree are being looked for.
> > 
> > You can also look in /proc/device_tree and make sure fsl-i2c is in there.

Here is what I get in /proc/device_tree:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
lutz:/proc/device-tree# tree
.
|-- #address-cells
|-- #size-cells
|-- aliases
|   |-- name
|   |-- pci0
|   |-- serial0
|   `-- serial1
|-- chosen
|   |-- bootargs
|   |-- linux,platform
|   |-- linux,stdout-path
|   `-- name
|-- compatible
|-- cpus
|   |-- #address-cells
|   |-- #size-cells
|   |-- PowerPC,603e
|   |   |-- bus-frequency
|   |   |-- clock-frequency
|   |   |-- d-cache-size
|   |   |-- device_type
|   |   |-- i-cache-size
|   |   |-- name
|   |   |-- reg
|   |   `-- timebase-frequency
|   `-- name
|-- memory
|   |-- device_type
|   |-- name
|   `-- reg
|-- model
|-- name
`-- soc10x
    |-- #address-cells
    |-- #size-cells
    |-- compatible
    |-- device_type
    |-- i2c@80003000
    |   |-- #address-cells
    |   |-- #size-cells
    |   |-- cell-index
    |   |-- compatible
    |   |-- interrupt-parent
    |   |-- interrupts
    |   |-- name
    |   |-- reg
    |   `-- rtc@32
    |       |-- compatible
    |       |-- device_type
    |       |-- name
    |       `-- reg
    |-- interrupt-controller@80040000
    |   |-- #address-cells
    |   |-- #interrupt-cells
    |   |-- compatible
    |   |-- device_type
    |   |-- interrupt-controller
    |   |-- linux,phandle
    |   |-- name
    |   `-- reg
    |-- name
    |-- pci@fec00000
    |   |-- #address-cells
    |   |-- #interrupt-cells
    |   |-- #size-cells
    |   |-- bus-range
    |   |-- clock-frequency
    |   |-- compatible
    |   |-- device_type
    |   |-- interrupt-map
    |   |-- interrupt-map-mask
    |   |-- interrupt-parent
    |   |-- name
    |   |-- ranges
    |   `-- reg
    |-- ranges
    |-- reg
    |-- serial@80004500
    |   |-- cell-index
    |   |-- clock-frequency
    |   |-- compatible
    |   |-- current-speed
    |   |-- device_type
    |   |-- interrupt-parent
    |   |-- interrupts
    |   |-- name
    |   `-- reg
    |-- serial@80004600
    |   |-- cell-index
    |   |-- clock-frequency
    |   |-- compatible
    |   |-- current-speed
    |   |-- device_type
    |   |-- interrupt-parent
    |   |-- interrupts
    |   |-- name
    |   `-- reg
    `-- store-gathering

12 directories, 86 files
lutz:/proc/device-tree# 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Under that I see:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
lutz:/proc/device-tree# grep -r -i fsl .
Binary file ./soc10x/i2c@80003000/compatible matches
lutz:/proc/device-tree# 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

The contents of that file:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
fsl-i2c^@
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Is there any further information that I can provide so that we can get
things fixed?

Thanks,

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
