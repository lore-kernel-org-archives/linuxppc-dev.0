Return-Path: <jothiadithya@yahoo.com>
Received: from web112304.mail.gq1.yahoo.com (web112304.mail.gq1.yahoo.com
	[98.137.26.132]) by ozlabs.org (Postfix) with SMTP id 381BAB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Dec 2009 00:23:29 +1100 (EST)
Message-ID: <107858.98423.qm@web112304.mail.gq1.yahoo.com>
References: <mailman.3.1261962001.8147.linuxppc-dev@lists.ozlabs.org>
Date: Mon, 28 Dec 2009 05:23:27 -0800 (PST)
From: Jothi Adithya <jothiadithya@yahoo.com>
Subject: SPI - ADS7846 driver
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <mailman.3.1261962001.8147.linuxppc-dev@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-507734825-1262006607=:98423"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-507734825-1262006607=:98423
Content-Type: text/plain; charset=us-ascii

Hi

I am using Xilinx Virtex4 Powerpc. I am trying to interface with ADS7846 SPI touch screen controller. This is connected to the Xilinx SPI. The CS is connected to a GPIO & PEN_IRQ is connected to different GPIO.

My DTS is
            
             //Chip Select
              SPI_CS: gpio@81400000 {
compatible = "xlnx,xps-gpio-1.00.a";
reg = < 0x81400000 0x10000 >;
xlnx,all-inputs = <0x0>;
xlnx,all-inputs-2 = <0x0>;
xlnx,dout-default = <0x0>;
xlnx,dout-default-2 = <0x0>;
xlnx,family = "virtex4";
xlnx,gpio-width = <0x4>;
xlnx,interrupt-present = <0x0>;
xlnx,is-bidir = <0x1>;
xlnx,is-bidir-2 = <0x1>;
xlnx,is-dual = <0x0>;
xlnx,tri-default = <0xffffffff>;
xlnx,tri-default-2 = <0xffffffff>;
} ;

               //Touch Screen (ADS7846) pen irq
 
               ts_pen_irq: gpio@81c00000 {
compatible = "xlnx,xps-gpio-1.00.a";
interrupt-parent = <&xps_intc_0>;
interrupts = < 0 2 >;
reg = < 0x81c00000 0x10000 >;
xlnx,all-inputs = <0x1>;
xlnx,all-inputs-2 = <0x0>;
xlnx,dout-default = <0x0>;
xlnx,dout-default-2 = <0x0>;
xlnx,family = "virtex4";
xlnx,gpio-width = <0x1>;
xlnx,interrupt-present = <0x1>;
xlnx,is-bidir = <0x1>;
xlnx,is-bidir-2 = <0x1>;
xlnx,is-dual = <0x0>;
xlnx,tri-default = <0xffffffff>;
xlnx,tri-default-2 = <0xffffffff>;
} ;
       
               // This is SPI
               xps_spi_ts: xps-spi@42400000 {
compatible = "xlnx,xps-spi-2.00.b", "xlnx,xps-spi-2.00.a";
reg = < 0x42400000 0x200 >;
xlnx,family = "virtex4";
xlnx,fifo-exist = <0x0>;
xlnx,num-ss-bits = <0x1>;
xlnx,num-transfer-bits = <0x8>;
xlnx,sck-ratio = <0xd0>;
} ;

          when I include the ADS7846 info in virtex.c file, the ADS7846 is detected & I could see at /dev/input/event0. But I do not know how to call or access the particluat GPIO in virtex.c file for Chipselect & for Irq.

         Please let me know how to do this


      
--0-507734825-1262006607=:98423
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:'times new roman', 'new york', times, serif;font-size:14pt"><div><font class="Apple-style-span" face="arial, helvetica, sans-serif" size="3"><span class="Apple-style-span" style="font-size: 13px;"><font class="Apple-style-span" face="'times new roman', 'new york', times, serif" size="6"><span class="Apple-style-span" style="font-size: 19px;">Hi</span></font></span></font></div><div><br></div><div>I am using Xilinx Virtex4 Powerpc. I am trying to interface with ADS7846 SPI touch screen controller. This is connected to the Xilinx SPI. The CS is connected to a GPIO &amp; PEN_IRQ is connected to different GPIO.</div><div><br></div><div>My DTS is</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //Chip Select</div><div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;SPI_CS:
 gpio@81400000 {</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>compatible = "xlnx,xps-gpio-1.00.a";</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>reg = &lt; 0x81400000 0x10000 &gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,all-inputs = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,all-inputs-2 = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,dout-default = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,dout-default-2 = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,family = "virtex4";</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,gpio-width = &lt;0x4&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,interrupt-present =
 &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,is-bidir = &lt;0x1&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,is-bidir-2 = &lt;0x1&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,is-dual = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,tri-default = &lt;0xffffffff&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,tri-default-2 = &lt;0xffffffff&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>} ;</div><div><br></div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //Touch Screen (ADS7846) pen irq</div><div>&nbsp;</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ts_pen_irq:&nbsp;gpio@81c00000 {</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>compatible =
 "xlnx,xps-gpio-1.00.a";</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>interrupt-parent = &lt;&amp;xps_intc_0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>interrupts = &lt; 0 2 &gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>reg = &lt; 0x81c00000 0x10000 &gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,all-inputs = &lt;0x1&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,all-inputs-2 = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,dout-default = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,dout-default-2 = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,family = "virtex4";</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,gpio-width =
 &lt;0x1&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,interrupt-present = &lt;0x1&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,is-bidir = &lt;0x1&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,is-bidir-2 = &lt;0x1&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,is-dual = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,tri-default = &lt;0xffffffff&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,tri-default-2 = &lt;0xffffffff&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>} ;</div><div>&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // This is SPI</div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;xps_spi_ts: xps-spi@42400000
 {</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>compatible = "xlnx,xps-spi-2.00.b", "xlnx,xps-spi-2.00.a";</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>reg = &lt; 0x42400000 0x200 &gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,family = "virtex4";</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,fifo-exist = &lt;0x0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,num-ss-bits = &lt;0x1&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,num-transfer-bits = &lt;0x8&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>xlnx,sck-ratio = &lt;0xd0&gt;;</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>} ;</div><div><br></div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;when I include the ADS7846 info in virtex.c file, the ADS7846
 is detected &amp; I could see at /dev/input/event0. But I do not know how to call or access the particluat GPIO in virtex.c file for Chipselect &amp; for Irq.</div><div><br></div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; Please let me know how to do this</div><div><br></div><div>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div><div>&nbsp;&nbsp; &nbsp;&nbsp;</div><div>&nbsp;&nbsp; &nbsp;</div><div><br></div><div><br></div><div><br></div></div><div style="position:fixed"></div>


<!-- cg13.c4.mail.gq1.yahoo.com compressed/chunked Wed Dec  9 00:51:07 PST 2009 -->
</div><br>

      </body></html>
--0-507734825-1262006607=:98423--
