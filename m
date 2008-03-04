Return-Path: <s104259@yahoo.it>
Date: Tue, 4 Mar 2008 17:38:53 +0100 (CET)
From: Angelo <s104259@yahoo.it>
Subject: RE: I2S driver
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
In-Reply-To: <BLU106-W3340DC3BF1A9FD27E9FCD3CA100@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1481751835-1204648733=:10329"
Message-ID: <538035.10329.qm@web23104.mail.ird.yahoo.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1481751835-1204648733=:10329
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Pedro wrote:
 Ok, here down is the code I told you.
A few considerations before:
 - As I told you, it is very bad commented, sorry. I'm still working on it.
 - It's is not an alsa driver, but it copies data to the PSC working as SPI mode (it is not I2S but you only need to change the PSC configuration).
 - Its purpose is to establish a dma task to copy the data from a buffer to the PSC, where I had attached a Digital to Analog Converter that into sound through a speaker.
 - Data alignment is imposed by DAC requirements.
 - Clock configuration is fixed to 44.1 Khz, so audio data must be sampled using that frequency. Data must be also mono (only one converter attached).
 - This module is part of a mayor project to stream audio data through ethernet, so it provides a function to copy audio data to audio buffers. If there's no data to copy, it copies a null buffer to keep silence.
 - What can you find useful in this code? Configuration steps to establish DMA Tasks and PSC configuration.
 - After the module I send you also the code from another module that establishes PSC as I2S configuration. Clocks where adjusted to send the audio data also at 44.1 Khz as fine tunned as possible due to communication requirements of the attached DAC in that hardware.

And finally, here is the code:

#define SPI_DBG

#ifdef SPI_DBG
#define DBG(x...) printk("(debug) " x)
#else
#define DBG(x...)
#endif

#include 
#include 
#include 
#include 
#include 
#include 
.....
 Thanks for code.
 But why i can't see library?
 
 >After the module I send you also the code from another module that >establishes PSC as I2S configuration. Clocks where adjusted to send >the audio data also at 44.1 Khz as fine tunned as possible due to >communication requirements of the attached DAC in that hardware.
 You'll send me another code?
 
 And what about my file lite5200b.dts?
 I must enable some like this?
         // PSC3 in CODEC mode example
         //i2s@2400 {        // PSC3
         //    device_type = "sound";
         //    compatible = "mpc5200b-psc-i2s";//not 5200 compatible
         //    cell-index = <2>;
         //    reg = <2400 100>;
         //    interrupts = <2 3 0>;
         //    interrupt-parent = <&mpc5200_pic>;
         //};


       
---------------------------------
L'email della prossima generazione? Puoi averla con la Nuova Yahoo! Mail
--0-1481751835-1204648733=:10329
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<i>Pedro wrote:</i><br> <blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">Ok, here down is the code I told you.<br>A few considerations before:<br> - As I told you, it is very bad commented, sorry. I'm still working on it.<br> - It's is not an alsa driver, but it copies data to the PSC working as SPI mode (it is not I2S but you only need to change the PSC configuration).<br> - Its purpose is to establish a dma task to copy the data from a buffer to the PSC, where I had attached a Digital to Analog Converter that into sound through a speaker.<br> - Data alignment is imposed by DAC requirements.<br> - Clock configuration is fixed to 44.1 Khz, so audio data must be sampled using that frequency. Data must be also mono (only one converter attached).<br> - This module is part of a mayor project to stream audio data through ethernet, so it provides a function to copy audio data to audio buffers. If there's no data to
 copy, it copies a null buffer to keep silence.<br> - What can you find useful in this code? Configuration steps to establish DMA Tasks and PSC configuration.<br> - After the module I send you also the code from another module that establishes PSC as I2S configuration. Clocks where adjusted to send the audio data also at 44.1 Khz as fine tunned as possible due to communication requirements of the attached DAC in that hardware.<br><br>And finally, here is the code:<br><br>#define SPI_DBG<br><br>#ifdef SPI_DBG<br>#define DBG(x...) printk("(debug) " x)<br>#else<br>#define DBG(x...)<br>#endif<br><br>#include <br>#include <br>#include <br>#include <br>#include <br>#include <br></blockquote>.....<br> Thanks for code.<br> But why i can't see library?<br> <br> &gt;After the module I send you also the code from another module that &gt;establishes PSC as I2S configuration. Clocks where adjusted to send &gt;the audio data also at 44.1 Khz as fine tunned as possible due to
 &gt;communication requirements of the attached DAC in that hardware.<br> You'll send me another code?<br> <br> And what about my file lite5200b.dts?<br> I must enable some like this?<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // PSC3 in CODEC mode example<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //i2s@2400 {&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // PSC3<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; device_type = "sound";<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; compatible = "mpc5200b-psc-i2s";//not 5200 compatible<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; cell-index = &lt;2&gt;;<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; reg = &lt;2400 100&gt;;<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; interrupts = &lt;2 3 0&gt;;<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpc5200_pic&gt;;<br> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 //};<BR><BR><p>&#32;


      <hr size=1><font face="Arial" size="2">L'email della prossima generazione? Puoi averla con la <a href="http://us.rd.yahoo.com/mail/it/taglines/hotmail/nowyoucan/nextgen/*http://it.docs.yahoo.com/nowyoucan.html">Nuova Yahoo! Mail</a></font>
--0-1481751835-1204648733=:10329--
