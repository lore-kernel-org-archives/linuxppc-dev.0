Date: Thu, 3 Aug 2000 16:27:30 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Jack Howarth <howarth@bromo.med.uc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
In-Reply-To: <200008021607.JAA13404@bromo.med.uc.edu>
Message-ID: <Pine.LNX.4.21.0008031553050.6100-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2 Aug 2000, Jack Howarth wrote:

>
> Kostas,
>     So what will we end up when we build 4.0.1 using those patches you
> provided today? Will we gain any dri acceleration on the r128 driver?
> Or will we still need to apply additional patches for that. I am
> still a tad confused about exactly how dependent the DRI code is in
> 4.0.1 on AGPgart. I am assuming if you set the AGPgart flag to NO
> in host.def then DRI will be built without any code requiring AGPgart
> to be available. Or am I misunderstanding the situation. I think
> I will try building the dri modules tonight and see what happens in
> the Mesa gears demo since that benchmarks framerate. Do you know what
> additional lines have to be added into XF86Config to enable the DRI
> modules? Thanks in advance.
>                   Jack
>

You don't have to define AGPgart flag to NO, the r128 module builds
fine without any other changes, the only problem without the agpgart
module will be lower performance (this might have changed though
by now).

To get DRI working we need a few other changes as well, the R128_READ/WRITE
macros need to do byteswapping/eieio. Writes to the CCE ring buffer might
need byteswapping as well but i am not sure (i haven't read the r128 docs
yet).

The only required change in XF86Config is to load the dri module
and configure the permissions for the device.

Section "Module
...
  Load  "dri"
...
EndSection

Section "DRI"
  Mode 0666
EndSection


  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
