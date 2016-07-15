Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrYfQ4XgxzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 23:42:37 +1000 (AEST)
Date: Fri, 15 Jul 2016 14:42:10 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160715134209.GF1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <4321972.HZgDox36RC@wuerfel> <3520758.yAgMzqF1PF@hactar>
 <5547846.5l81k4b13o@wuerfel> <20160715132610.GD23514@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715132610.GD23514@redhat.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 15, 2016 at 09:26:10AM -0400, Vivek Goyal wrote:
> On Fri, Jul 15, 2016 at 09:31:02AM +0200, Arnd Bergmann wrote:
> > I think that helps, as it makes the problem space correspond to that
> > of modifying the command line, but I can still come up with countless
> > attacks based on modifications of the /chosen node and/or the command
> > line, in fact it's probably easier than any other node.
> 
> I don't know anything about DTB. So here comes a very basic question. Does
> DTB allow passing an executable blob to kernel or pass the location of
> some unsigned executable code at kernel level.

DT on ARM is a description of the hardware - it can be thought of as a
set of nodes with properties attached.  The properties can describe
anything (we have documentation in Documentation/devicetree/bindings
which describes what we expect the properties to contain.)

On other architectures, DT can also contain open-firmware "functions"
but I don't think there's much support in the kernel for that - maybe
the PPC folk can reply on that point.

It is possible that someone may, at some point, decide to create a
property that points to some executable blob, but I can't think of a
reason why we should ever allow such a monstrosity in mainline kernels.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
