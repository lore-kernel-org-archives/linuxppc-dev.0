Return-Path: <michael@ellerman.id.au>
Date: Tue, 25 Jun 2013 11:50:57 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH] Do not update sysfs cpu registration from invalid context
Message-ID: <20130625015057.GC14051@concordia>
References: <51C8543F.6080905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51C8543F.6080905@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 24, 2013 at 09:14:23AM -0500, Nathan Fontenot wrote:
> The topology update code that updates the cpu node registration in sysfs
> should not be called while in stop_machine(). The register/unregister
> calls take a lock and may sleep.
> 
> This patch moves these calls outside of the call to stop_machine().

What happens? Do we lockup or do you just get a warning?

And what commit introduced the breakage?

cheers
