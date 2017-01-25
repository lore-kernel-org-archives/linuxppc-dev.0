Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7WwW3wx6zDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 15:17:15 +1100 (AEDT)
Date: Tue, 24 Jan 2017 22:17:02 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jan Stancek <jstancek@redhat.com>,
 Herton Krzesinski <hkrzesin@redhat.com>,
 Artem Savkov <asavkov@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug] stack protector panics on v4.10-rc1+
Message-ID: <20170125041702.GM30284@gate.crashing.org>
References: <627000186.495731.1485210132000.JavaMail.zimbra@redhat.com>
 <1761847918.511957.1485216600665.JavaMail.zimbra@redhat.com>
 <20170124010421.GI30284@gate.crashing.org>
 <8737g9azuj.fsf@concordia.ellerman.id.au>
 <87ziih9jzv.fsf@concordia.ellerman.id.au>
 <20170125035453.GA12855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170125035453.GA12855@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 09:24:53AM +0530, Balbir Singh wrote:
> > So my inclination is to revert the powerpc stack protector code for
> > 4.10, and we can try again for 4.11 or 12.
> 
> That makes sense. We then wait for the right gcc version? I guess we also
> push for per-task gaurd value as opposed to a global one?

Global value will work (with GCC 7) as-is.  Per-task will require some
kernel work, but yeah you want it, that is why the options for that exist ;-)

You don't have to revert the current stack protector code; just condition it
on the relevant GCC flags (you will need to do that later anyway).


Segher
