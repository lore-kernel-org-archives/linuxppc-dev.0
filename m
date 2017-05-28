Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbSGB3xlWzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 03:55:46 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id w69so9864559pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 May 2017 10:55:46 -0700 (PDT)
Date: Sun, 28 May 2017 10:55:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Message-ID: <20170528175540.GA8094@dtor-ws>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws> <20170528114758.52b619f2@neko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170528114758.52b619f2@neko>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 28, 2017 at 11:47:58AM +0200, Michal Suchanek wrote:
> On Tue, 9 May 2017 17:43:27 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Michal,
> > 
> > On Tue, May 09, 2017 at 09:14:18PM +0200, Michal Suchanek wrote:
> > > There is nothing mac-specific about this driver. Non-mac hardware
> > > with suboptimal built-in pointer devices exists.
> > > 
> > > This makes it possible to use this emulation not only on x86 and ppc
> > > notebooks but also on arm and mips.  
> > 
> > I'd rather we did not promote from drivers/macintosh to other
> > platforms, but rather removed it. The same functionality can be done
> > from userspace.
> 
> What is the status of this?

The same as in above paragraph.

> 
> Do you reply to every patch to drivers/input that is not the the core
> infrastructure that you would rather drop the driver because it can be
> done is in userspace?
> 
> It sure can be done. Remove everything but the bus drivers and uinput
> from drivers/input and the rest can be done in userspace.
> 
> The question is who does it?
> 
> Are you saying that you will implement the userspace equivalent?

No, I spend my time mostly with the kernel.

> 
> If not then please do your job as maintainer and accept trivial patches
> for perfectly working drivers we have now.

I am doing my job as a maintainer right now. The driver might have been
beneficial 15 years ago, when we did not have better options, but I
would rather not continue expanding it's use.

The main problem with the driver is that the functionality it is not
easily discoverable by end users. And once you plumb it through
userspace to present users with options you might as well handle it all
in userspace.

> 
> If you want to move drivers/input into userspace I am not against it
> but I am not willing to do that for you either.

Then we are at impasse.

> 
> > 
> > What hardware do you believe would benefit from this and why?
> 
> Any touchpad hardware where you cannot press two buttons at once to
> emulate the third button due to hardware design. And any touchpad
> hardware on which some of the buttons are broken when it comes to it.
> 
> It is built into a notebook and works fine for moving the cursor but
> due to lack of usable buttons you still need a mouse to use the
> notebook.

Have you tried simply redefining keymap of your keyboard to emit
BTN_RIGHT/BTN_MIDDLE? Both atkbd and HID keyboards support keymap
updates from userspace/udev/hwdb and if there is a driver that does not
support it I will take patches fixing that.

Thanks.

-- 
Dmitry
