Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id CEF8CDE025
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 04:02:25 +1100 (EST)
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
	<m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
	<1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
	<20070129165217.GA10992@colo.lackof.org> <adabqkh22jy.fsf@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 29 Jan 2007 09:02:18 -0800
In-Reply-To: <adabqkh22jy.fsf@cisco.com> (Roland Dreier's message of "Mon,
	29 Jan 2007 08:57:53 -0800")
Message-ID: <ada7iv522cl.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>, Brice Goglin <brice@myri.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Really?  Which gigE chips are using MSI-X (as opposed to MSI)?

OK, I should look before I post.  But anyway a quick grep shows that
the forcedeth driver does enable MSI-X for at least some devices.  And
a quick look at the nv_suspend() function makes me think that suspend
probably won't work if MSI-X is used, since it doesn't save the MSI-X
state anywhere that I can see (unless the device is magic enough to
keep the MSI-X table in some sort of persistent storage, which I
highly doubt).

 - R.
