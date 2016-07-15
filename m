Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrYHT37Q4zDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 23:26:13 +1000 (AEST)
Date: Fri, 15 Jul 2016 09:26:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org,
 bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160715132610.GD23514@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <4321972.HZgDox36RC@wuerfel> <3520758.yAgMzqF1PF@hactar>
 <5547846.5l81k4b13o@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5547846.5l81k4b13o@wuerfel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 15, 2016 at 09:31:02AM +0200, Arnd Bergmann wrote:
> On Thursday, July 14, 2016 10:44:14 PM CEST Thiago Jung Bauermann wrote:
> > Am Donnerstag, 14 Juli 2016, 10:29:11 schrieb Arnd Bergmann:
> 
> > > 
> > > Right, but the question remains whether this helps while you allow the
> > > boot loader to modify the dtb. If an attacker gets in and cannot modify
> > > the kernel or initid but can modify the DT, a successful attack would
> > > be a bit harder than having a modified kernel, but you may still need
> > > to treat the system as compromised.
> > 
> > Yes, and the same question also remains regarding the kernel command line.
> > 
> > We can have the kernel perform sanity checks on the device tree, just as the 
> > kernel needs to sanity check the command line.
> > 
> > There's the point that was raised about not wanting to increase the attack 
> > surface, and that's a valid point. But at least in the way Petitboot works 
> > today, it needs to modify the device tree and pass it to the kernel.
> > 
> > One thing that is unavoidable to come from userspace is 
> > /chosen/linux,stdout-path, because it's Petitboot that knows from which 
> > console the user is interacting with. The other modification to set 
> > properties in vga@0 can be done in the kernel.
> > 
> > Given that on DTB-based systems /chosen is an important and established way 
> > to pass information to the operating system being booted, I'd like to 
> > suggest the following, then:
> > 
> > Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
> > accepting a complete DTB from userspace, the syscall would accept a DTB 
> > containing only a /chosen node. If the DTB contains any other node, the 
> > syscall fails with EINVAL. The kernel can then add the properties in /chosen 
> > to the device tree that it will pass to the next kernel.
> > 
> > What do you think?
> 
> I think that helps, as it makes the problem space correspond to that
> of modifying the command line, but I can still come up with countless
> attacks based on modifications of the /chosen node and/or the command
> line, in fact it's probably easier than any other node.

I don't know anything about DTB. So here comes a very basic question. Does
DTB allow passing an executable blob to kernel or pass the location of
some unsigned executable code at kernel level. I think from secureboot point of
view that would be a concern. Being able to trick kernel to execute an
unsigned code at privileged level.

Vivek
