Return-Path: <wmb@firmworks.com>
Message-ID: <4EB84E24.9000000@firmworks.com>
Date: Mon, 07 Nov 2011 11:31:16 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Robert Sciuk <robert.sciuk@exfo.com>
Subject: Re: fpga driver on custom PPC target platform (P4080) ...
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
 <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4C0100C8C1@SPQCEXC05.exfo.com>
 <20111105004050.GA1384@truffala.fritz.box>
 <2DD52030B5146141BEB762A11AE97C4C0100CB3D@SPQCEXC05.exfo.com>
In-Reply-To: <2DD52030B5146141BEB762A11AE97C4C0100CB3D@SPQCEXC05.exfo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/7/2011 10:09 AM, Robert Sciuk wrote:
> In my continuing saga of dev/tree driver development, I have a problem which might be obvious to those who have more experience in such matters.
>
> I'm a bit perplexed on the tree nodes for the localbus/simplebus nodes for my FPGA.  CS0 is reserved for booting (from NOR flash as required by our design), CS1 is tied to an FPGA which will always be present.  CS2 actually is tied to both of two (optional) fpga's, which have been previously mapped by U-Boot (BRn/ORn configuration).  Should I specify a ranges command as follows?  This seems somehow wrong, to me, and I'm wondering if there is an alternative representation which would work better in this case.  If you recall, the programming control lines are handled on the I2C bus, via a gpio controller.  In an ideal world, the optional FPE1 and FPE2 fpgas will have the identical .bts stream, and should support the option to program both simultaneously, or each individually, but I'm at a loss as how to best represent this in the tree.

I would be tempted to add another level of hierarchy as a container for 
the two FPEs on CS2.

>
> 	        localbus@ffe124000 {
>                  compatible = "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
>                  reg =<0xf 0xfe124000 0 0x1000>;
>                  interrupts =<25 2 0 0>;
>                  interrupt-parent =<&mpic>;
>                  #address-cells =<2>;
>                  #size-cells =<1>;
>
>                  /* Local bus region mappings */
>                  ranges =<0 0 0xf 0xe8000000 0x08000000         /* CS0: Boot flash */
>                            1 0 0xf 0xd0000000 0x7fff             /* CS1: FPGA0 -  LIM */
>                            2 0 0xf 0xd1000000 0x7fff             /* CS2: FPGA1 -  FPE1 */
>                            2 0 0xf 0xd2000000 0x7fff>;          /* CS2: FPGA2 -  FPE2 */
>
>                  flash@0,0 {
>                          compatible = "cfi-flash";
>                          reg =<0 0 0x08000000>;
>                          bank-width =<2>;
>                          device-width =<2>;
>                          #size-cells =<1>;
>                          #address-cells =<1>;
>
>                          partition@0 {
>                                  label = "rcw";
>                                  reg =<0x0 0x20000>;
>                                  read-only;
>                          };
>                          partition@40000 {
>                                  label = "saveenv";
>                                  reg =<0x40000 0x20000>;
>                          };
>                          partition@7000000 {
>                                  label = "fman-firmware";
>                                  reg =<0x7000000 0x20000>;
>                                  read-only;
>                          };
>                          partition@7f80000 {
>                                  label = "u-boot";
>                                  reg =<0x7f80000 0x80000>;
>                                  read-only;
>                          };
>                  };
>
>                  lim: fpga@1, {
>                  }
>
>                  fpe1: fpga@2, {
>                  }
>
>                  fpe2: fpga@2, {
> 	}
>
> Again, any pointers here would be greatly appreciated ...
>
> Cheers,
> Rob Sciuk
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
