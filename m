Return-Path: <Hollis_Blanchard@mentor.com>
Subject: "status" property checks
From: Hollis Blanchard <hollis_blanchard@mentor.com>
To: devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Jan 2010 15:07:53 -0800
Message-ID: <1262905673.11702.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Right now, a number of drivers honor the "status" property on device
nodes (via of_device_is_available() checks), but it's open-coded in each
driver. I'm thinking of "hiding" arbitrary devices from the kernel, and
setting this property seems like the best approach, but at the moment
that would require modifying all OF drivers to check for it.

Wouldn't the better approach be to have of_platform_device_probe()
itself do the check, and not call the driver's probe() routine if the
device isn't available?

--=20
Hollis Blanchard
Mentor Graphics, Embedded Systems Division
