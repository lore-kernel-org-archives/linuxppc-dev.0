Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17451.30312.967754.699319@cargo.ozlabs.ibm.com>
Date: Thu, 30 Mar 2006 17:10:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
In-Reply-To: <bed6c40abe7664da7506270a46611d00@embeddededge.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<bed6c40abe7664da7506270a46611d00@embeddededge.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek writes:

> I haven't followed the device tree development in detail, but when
> looking at this the only question that comes to mind is wondering
> what this really does to help me.  None of the information provided
> here is variable nor configurable .... except I guess for the internal
> register base address (IMMR), which for some reason has turned
> into a variable which hasn't changed since I did the first kernel port.
> About the only thing that is variable, which is the two different bank
> addresses of the CPM memory that affects the configuration of
> the FCCs in Ethernet mode, isn't reflected here in any way.

I don't know much about the CPM or CPM2, so I don't know precisely why
these bits have been put in.  If the CPM2 is completely unique and is
identical across all possible past and future implementations, then
indeed there isn't a lot of value in putting details about it in the
device tree.  Having details in the device tree becomes useful if:

* there are variants that have different collections of subdevices, or
  subdevices at different offsets, or

* there are common subdevices between CPM and CPM2 (or future CPM*
  devices), potentially with subtle variations in offset, method of
  enabling, etc., or

* there are subdevices in CPM/CPM2 which match some common device
  (e.g. a 16550 uart) for which a generic driver can be used with some
  appropriate configuration.

As I say, I don't know if these points apply to CPM/CPM2 specifically.

Paul.
