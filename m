Return-Path: <carlos@kenati.com>
Received: from mail.kenati.com (unknown [69.90.147.196])
	by ozlabs.org (Postfix) with ESMTP id 5EF94DDF4D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Apr 2007 09:27:18 +1000 (EST)
Message-ID: <461582A0.3010403@kenati.com>
Date: Thu, 05 Apr 2007 16:13:36 -0700
From: Carlos Munoz <carlos@kenati.com>
MIME-Version: 1.0
To: Akhilesh Soni <akhilesh@innomedia.soft.net>
Subject: Re: Advice on Linux Framebuffer driver implemetation
References: <004d01c77681$3bdbae60$0a12a8c0@innomedia>
In-Reply-To: <004d01c77681$3bdbae60$0a12a8c0@innomedia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Akhilesh Soni wrote:
> Hello,
>  
> I want advice on how to proceed for the following problem
>  
> As per my knowledge the *Linux frame buffer* requires the pixel data 
> to be in a packed pixel *contiguous buffer*. This means that the all 
> the data for one pixel must be packed together, followed by the data 
> for the next pixel, etc.(please correct me if I'm wrong)
>  
>  On my Set-top-box hardware Vulcan (IBM ppc405),  the best 
> resolution supported  in this packed pixel format is 8bpp color table 
> format. Vulcan resolutions above the 8bpp color table resolution 
>  require separate  luma and chroma buffers,  where the hardware 
> expects all the luma values to be in one buffer and all chroma values 
> to be in another buffer. Since the data for the resolutions above 8bpp 
> are required by the hardware to be in separate luma and chroma buffers 
> it does not meet the LInux Frame buffer requirement of packed pixel data.
> Now how can I overcome this limitation where graphics H/W expects 
> separate Luma and Chroma buffers whereas linux framebuffer expect all 
> things packed. Is there any such driver already present which I can 
> study to overcome such limitation.
Hi Akhilesh,

I would write a new frame buffer driver for your hardware that converts 
RGB565 data (or whatever format is passed to the frame buffer) to 
luma/chroma data. There might be some open source libraries that already 
do this conversion. Writing a frame buffer driver is not very difficult.

Carlos
