Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvbld2rJBzDqTN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 22:27:40 +1000 (AEST)
Date: Wed, 20 Jul 2016 08:27:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com,
 arnd@arndb.de, Petr Tesarik <ptesarik@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, dyoung@redhat.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160720122737.GA11361@redhat.com>
References: <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
 <20160713130338.GB16900@redhat.com>
 <20160713174009.GA1041@n2100.armlinux.org.uk>
 <20160713182247.GA25232@redhat.com>
 <1468845964.2800.3.camel@gmail.com>
 <20160718132629.GB32512@redhat.com>
 <8a8b2909-7f95-03e4-bf8e-dd29b5fc1fba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8a8b2909-7f95-03e4-bf8e-dd29b5fc1fba@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 20, 2016 at 01:45:42PM +1000, Balbir Singh wrote:
> >>>>>  
> >>>>> Command line options are not signed. I thought idea behind secureboot
> >>>>> was to execute only trusted code and command line options don't enforce
> >>>>> you to execute unsigned code.
> >>>>>  
> >>
> >> You can set module.sig_enforce=0 and open up the system a bit assuming
> >> that you can get a module to load with another attack
> > 
> > IIUC, sig_enforce bool_enable_only so it can only be enabled. Default
> > value of it is 0 if CONFIG_MODULE_SIG_FORCE=n.
> > 
> > IOW, if your kernel forced signature verification, you should not be
> > able to do sig_enforce=0. If you kernel did not have
> > CONFIG_MODULE_SIG_FORCE=y, then sig_enforce should be 0 by default anyway
> > and you are not making it worse using command line.
> > 
> 
> OK.. I checked and you are right, but that is an example and there are
> other things like security=, thermal.*, nosmep, nosmap that need auditing
> for safety and might hurt the system security if used. I still think
> think that assuming you can pass any command line without breaking security
> is a broken argument.

I agree that if some command line option allows running unsigned code
at ring 0, then we probably should disable that on secureboot enabled
boot.

In fact, there were bunch of patches which made things tighter on
secureboot enabled machines from matthew garrett. AFAIK, these patches
never went upstream.

Vivek
