Message-ID: <004b01bf5b05$51035440$73f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Mark Vojkovich" <mvojkovich@varesearch.com>,
        "XFree86 Devel" <devel@XFree86.Org>
Cc: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Question about the video device driver
Date: Mon, 10 Jan 2000 08:54:55 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm a newbie in the X domain,
where can I get the information about showfb?
As I know, there is no hardware for MPC823 FADS that can do the
conversion from RGB data stored in system memory,
we must do it using software.

So, where I should start?
Any suggestion?

>
>On Fri, 7 Jan 2000, Geert Uytterhoeven wrote:
>
>> On Fri, 7 Jan 2000, Shuangjun Zhu wrote:
>> > The video of MPC823 FADS board only support YCbYCr mode,
>> > so how can I write a device driver for the video of MPC823 FADS board,
>> > to enable the X?
>> > 
>> > Any suggestion? 
>> > Thanks in advanced.
>> 
>> This sounds like an interesting project.
>> 
>> How many bits per pixel are available? If it's not too much you can create a
>> staticcolor visual and consider it to be a simple paletted video mode (with a
>> static palette). However, IIRC, XFree86 doesn't support staticcolor hardware,
>> but support for that is probably closer than support for YCbCr.
>
>   We support static color visuals just fine.  But there will be
>a problem if the hardware doesn't have a macroblock size of 1x1.
>It's required that you can get read the data back without losing
>information.  If you are sharing chroma between pixels that's
>not going to work.
>
>> 
>> I see you write YCbYCr? So the color components are subsampled like digital
>> broadcast video? In that case things become more complex because of the
>> different resolutions for the luminance and chrominance channels.
>> 
>> All this combined, I think the best solution is to use the virtual frame buffer
>> feature of XFree86 3.9.x (draw in a piece of memory as large as the screen) and
>> update the screen image by converting the changed parts from RGB to YCbYCr.
>
>   Yes, shadowfb should work fine for this if the hardware can do the
>conversion from RGB data stored in system memory.
>


>
> Mark.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
