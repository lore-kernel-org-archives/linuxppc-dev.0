Date: Tue, 26 Nov 2002 09:09:28 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: PPC RTC on I2C
In-reply-to: <20021125230731.43D9DC58BF@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>, Matt Porter <porter@cox.net>
Cc: "Montgomery, Tim" <timm@artesyncp.com>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOEFFFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> [Matt]
> > I always thought that one would implement some low-level ppc-specific
> > i2c master access functions.  These would be available via a few
> > ppc_mds and one could have a generic i2c 'adapter' to call the
> > functions.  For RTC access, one would then have a i2c RTC implementation
> > using these access functions rather than using the generic PPC RTC
> > device.  This does bypass the bloated i2c layer, however.  If done

[Wolfgang]
> IMHO the whole I2C system is  (1)  overkill  and  (2)  unusable.  For
> example, we often have to deal with PICs and other devices on the I2C
> bus  where  you  must  first  issue a write operation (for example to
> select a register) followed  by  one  or  more  read  operations  (to
> receive  the  data).  This is difficult to implement application code
> that perform such accesses when there is more than  one  device,  and
> more  than one application process. Things get worse if you also have
> to provide simultaneous access tot he  I2C  bus  from  one  ore  more
> device drivers.

It's not unusable. For the kind of access you are describing there is
a ioctl() i/f where you kan combine all you read/write operations into
one atomic system call. It's available inside the kernel as a function
call, i2c_transfer(), as well.

Tim, if you are using a 8xx CPU, make sure to get a updated version of
the i2c-algo-8xx.c driver from BK curr, 2.4 devel branch.

  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
