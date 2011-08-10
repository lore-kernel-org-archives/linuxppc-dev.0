Return-Path: <paulus@ozlabs.org>
Date: Wed, 10 Aug 2011 22:26:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 10/10] KVM: PPC: Enable the PAPR CAP for Book3S
Message-ID: <20110810122632.GB5536@bloggs.ozlabs.ibm.com>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-11-git-send-email-agraf@suse.de>
	<20110810044215.GA5404@drongo>
	<0B73DEC7-C430-43D7-8095-D3D0BEDA27AA@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0B73DEC7-C430-43D7-8095-D3D0BEDA27AA@suse.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2011 at 09:59:41AM +0200, Alexander Graf wrote:
> 
> Am 10.08.2011 um 06:42 schrieb Paul Mackerras <paulus@samba.org>:
> 
> > On Tue, Aug 09, 2011 at 06:31:48PM +0200, Alexander Graf wrote:
> > 
> >> Now that Book3S PV mode can also run PAPR guests, we can add a PAPR cap and
> >> enable it for all Book3S targets. Enabling that CAP switches KVM into PAPR
> >> mode.
> > 
> > Don't we want to enable it only for 64-bit hosts?  Trying to run a
> > PAPR guest on a 32-bit Book 3S host won't work very well, unless I am
> > missing something...
> 
> I agree that it doesn't make sense, but if anything we should
> restrict it to 64-bit _guests_. you can also run 32-bit guests on
> 64-bit hosts.

I had a look in PAPR and I didn't find anything that says the
processor has to be 64-bit, so I guess a 32-bit PAPR guest is possible
in theory.  However, I don't think there are currently any 32-bit PAPR
operating systems that would use hcalls.

> And so far, we don't have a single interface setting PVR and PAPR
> mode at the same time, so you could still enable PAPR with a 64-bit
> guest CPU and then switch to a 32-bit CPU.
> 
> It'd be a nightmare to check all configurations on every setter function.
> 
> Unless...
> 
> We could introduce a sanity check function that gets executed every
> time we change PVR or enable PAPR. That could set a variable in the
> vcpu struct to indicate that the config is ok. We could then check
> that on vcpu_run.

It's probably not worth worrying about it.

The rest of the series looks very nice.

Regards,
Paul.
