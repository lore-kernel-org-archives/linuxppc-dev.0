Message-ID: <009201bf5b0b$01e4c140$73f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Mark Vojkovich" <mvojkovich@varesearch.com>
Cc: "XFree86 Devel" <devel@XFree86.Org>,
        "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Question about the video device driver
Date: Mon, 10 Jan 2000 09:35:39 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>
>
>On Mon, 10 Jan 2000, Shuangjun Zhu wrote:
>
>> I'm a newbie in the X domain,
>> where can I get the information about showfb?
>> As I know, there is no hardware for MPC823 FADS that can do the
>> conversion from RGB data stored in system memory,
>> we must do it using software.
>> 
>> So, where I should start?
>> Any suggestion?
>
>
>   Shadowfb is a "layer" (using the X terminology) which 
>is initialized after framebuffer rendering is setup.  It
>is given a callback function when initialized.
>
>typedef void (*RefreshAreaFuncPtr)(ScrnInfoPtr, int, BoxPtr);
>
>Bool
>ShadowFBInit (
>    ScreenPtr           pScreen,
>    RefreshAreaFuncPtr  refreshArea
>);
>
>  The shadowfb encapsulates all rendering into that buffer
>and gives the driver a callback telling it which rectangles
>of the buffer have been updated.
>
>   What can be done is that one can setup a framebuffer in 
>system memory and get callbacks telling which parts need to
>be copied into the real hardware framebuffer, hence the
>name - you have a buffer and its shadow.   It is safe to
>copy areas larger than the rectangles you are told to update.
>That way you can reduce your refreshArea function to copying
>and translating only macroblocks.
>
>   There are examples in some other drivers such as the
>glide driver which uses it on a write-only framebuffer or
>the MGA driver which uses it for effects like rotating
>the screen.
>
>   What format is the hardware buffer in?  What macroblock
>size?
> 


For the MPC823 FADS board, video controller is in the CPM, part of 
the CPU, and video encoder is ADV7176, video memory is map to 
the system memory.  It can support NTSC/PAL display.

MPC823 can support RGB and YCr Cb, but for Analog Devices ADV7176
video encoder,  it can only support 4:2:2 YCr Cb(CCIR 601) format.

I do not know what the macroblock's meaning is.

>
> Mark.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
