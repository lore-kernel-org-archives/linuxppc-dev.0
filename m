Message-ID: <3868F4EB.498E3466@netx4.com>
Date: Tue, 28 Dec 1999 12:35:39 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Help about device driver in Linux
References: <004a01bf50df$312fab80$70f102de@sjzhu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shuangjun Zhu wrote:

> I want to make two device driver for MPC823,
> one is for MPC823 Video, one is for MPC IIC.


Both of these exist in the 2.2.13 kernel on ppc.kernel.org.
I regularly use the video driver for LCDs.  It is pretty trivial,
just initializes the 823 and you can mmap() the frame buffer.
There is an ioctl() to set the color map.  I don't know what
to do with it from here, it works well enough for demos and
some custom software I have written.

There are some (relatively) undocumented features to set
aggressive mode display updates, don't mess this up or the
PPC core won't make any progress.  This code works equally
well on the 823 and 823e.  It will not work on the 821.


> Because in the Video driver, it must write configuration
> parameters to the video controller through the IIC driver.

I normally let the application program do this.  We can argue all
day about whether the video driver should have this knowledge, but
it is clearly easier if the application does it.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
