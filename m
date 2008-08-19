Return-Path: <FENKES@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CD40DDFFA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 20:53:18 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m7JAqAVn429602
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 10:52:10 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7JAqAcF4014268
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:52:10 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7JAq9Fi010782
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:52:10 +0200
In-Reply-To: <18602.18568.338552.482669@cargo.ozlabs.ibm.com>
References: <200808051630.19619.fenkes@de.ibm.com>
	<18602.18568.338552.482669@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ibmebus/of_platform: Move "name" sysfs attribute into
	generic OF devices
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFD6515867.CFE29C04-ONC12574AA.003B8D55-C12574AA.003BB443@de.ibm.com>
Date: Tue, 19 Aug 2008 12:52:07 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <pmac@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Alexander Schmidt1 <ALEXSCHM@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> wrote on 19.08.2008 06:14:00:
 
> > Recent of_platform changes made of_bus_type_init() overwrite the bus 
type's
> > .dev_attrs list, so move ibmebus' "name" attribute (which is needed by 
eHCA
> > userspace support) into generic OF device code. Tested on POWER.
> 
> Is this a bugfix that is needed for 2.6.27?

Yes, definitely. The eHCA userspace driver relies on the name attribute to 
check for valid adapters (it checks that the name is "lhca"), so with the 
name attribute gone, eHCA userspace will cease to work.

Regards,
  Joachim
