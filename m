Subject: Re: [PATCH][RFC] OCP support for MPC107 and relatives
From: Adrian Cox <adrian@humboldt.co.uk>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40CDDAC7.4090608@mvista.com>
References: <1087207803.7360.83.camel@newt>  <40CDDAC7.4090608@mvista.com>
Content-Type: text/plain
Message-Id: <1087287047.2374.6.camel@newt>
Mime-Version: 1.0
Date: Tue, 15 Jun 2004 09:10:47 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-14 at 18:05, Mark A. Greer wrote:

> That's great that you're OCP-ifying the mpc10x code!  My only comment is
> thatI don't like hardcoding the position of an entry in the OCP (e.g.,
> core_ocp[0].vedor/paddr).  I don't think its safe to assume that any
> particular piece of code will always know all of the entries in the OCP
> and therefore what an entry's position will be.  You can use
> 'ocp_for_each_device()' and a routine that checks for the fields that
> you want to accomplish the same thing.

I'll try to do a new version of the patch at the end of the week.

Would it work to have an empty core_ocp[] array, and then call
ocp_add_one_device() to insert the entries? That would deal with these
issues, as the code would look like:
mpc10x_i2c_ocp.paddr = phys_eumb_base + MPC10X_EUMB_I2C_OFFSET;
ocp_add_one_device(&mpc10x_i2c_ocp);

Then the MPC106 path would simply not add any entries, rather than
having to go through and mark them as invalid.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
