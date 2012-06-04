Return-Path: <michael@ellerman.id.au>
Message-ID: <1338792215.15716.5.camel@concordia>
Subject: Re: [PATCH] powerpc: pseries: Round up MSI-X requests
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Date: Mon, 04 Jun 2012 16:43:35 +1000
In-Reply-To: <20120604091545.03ce738b@kryten>
References: <20120604091545.03ce738b@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-04 at 09:15 +1000, Anton Blanchard wrote:
> The pseries firmware currently refuses any non power of two MSI-X
> request. Unfortunately most network drivers end up asking for that
> because they want a power of two for RX queues and one or two extra
> for everything else.
> 
> This patch rounds up the firmware request to the next power of two
> if the quota allows it.

There is some chance this will result in breakage because the driver
asks for N - and assumes that is what was allocated - and the device is
configured for > N.

But that's a hypothetical, and we know the current approach sucks
because it will result in many drivers falling back to a single
interrupt.

I think this is the least-worst approach in light of the FW limitations,
and we can always add quirks in here if we really have to.

Paul is the pseries maintainer so he gets to ACK or NAK it, but from an
MSI point of view it gets my +1.

cheers
