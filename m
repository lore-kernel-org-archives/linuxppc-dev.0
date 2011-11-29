Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0AD89B6F94
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2011 18:04:17 +1100 (EST)
Message-ID: <1322550115.23348.72.camel@pasglop>
Subject: Re: [RFC PATCH v2 1/4] cpuidle: (powerpc) Add cpu_idle_wait() to
 allow switching of idle routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 29 Nov 2011 18:01:55 +1100
In-Reply-To: <4ED47EC2.2090802@linux.vnet.ibm.com>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
 <20111117112830.9191.1951.stgit@localhost6.localdomain6>
 <1322434096.23348.6.camel@pasglop>	<4ED36A37.3030409@linux.vnet.ibm.com>
 <1322512522.23348.43.camel@pasglop> <4ED47EC2.2090802@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-29 at 12:12 +0530, Deepthi Dharwar wrote:
> 
> Yes, this could be problematic as there is small window for the
> race condition to occur . Otherwise we need to manually schedule
> it by running a kernel thread but this would definitely have a
> overhead and would be an overkill. 

Depends what this "window" is. IE. What are you trying to protect
yourself against ? What's the risk ?

If it's just module unload, then stop_machine is probably your
friend :-)

Cheers,
Ben.
