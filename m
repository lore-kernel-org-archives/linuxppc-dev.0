Return-Path: <hunter.cobbs@gmail.com>
Subject: Re: "status" property checks
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: Hollis Blanchard <hollis_blanchard@mentor.com>
In-Reply-To: <1262905673.11702.16.camel@localhost.localdomain>
References: <1262905673.11702.16.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Jan 2010 20:35:43 -0600
Message-ID: <1262918143.2716.8.camel@ccs-laptop>
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I think that is definitely a solution.  It does centralize the testing
for this particular issue.  The only thing question I have is if its
really better to have the upper level do the check.  Shouldn't the
driver itself handle the hardware and device node status?

On Thu, 2010-01-07 at 15:07 -0800, Hollis Blanchard wrote:
> Right now, a number of drivers honor the "status" property on device
> nodes (via of_device_is_available() checks), but it's open-coded in each
> driver. I'm thinking of "hiding" arbitrary devices from the kernel, and
> setting this property seems like the best approach, but at the moment
> that would require modifying all OF drivers to check for it.
> 
> Wouldn't the better approach be to have of_platform_device_probe()
> itself do the check, and not call the driver's probe() routine if the
> device isn't available?
> 
