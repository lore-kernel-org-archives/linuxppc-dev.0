Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [0/14] Ebony support, 2nd spi
Date: Tue, 20 Feb 2007 19:02:08 +0100
References: <20070220020837.GF17818@localhost.localdomain>
	<200702201607.33249.arnd@arndb.de>
	<814781c1228541df932f8f4c7cc6ea89@kernel.crashing.org>
In-Reply-To: <814781c1228541df932f8f4c7cc6ea89@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="Boundary-01=_hez2F5cRX5OyK9j"
Message-Id: <200702201902.09051.arnd@arndb.de>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-01=_hez2F5cRX5OyK9j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 20 February 2007 16:25, Segher Boessenkool wrote:
> >> And the ebony dts also has the a bus type of "ibm,opb" as well.
> >
> > We should really get a common name for these. I don't remember
> > what the discussions were, but it seems we came up with different
> > results for Axon and ppc4xx, which is very bad.
> 
> "Very bad"...  Well sure it's less than desirable, but
> we have to deal with this problem anyway already.
> 
> > Using type "ibm,opb" rather than just "opb" makes sense to me,
> > but I don't know if we already have shipping systems that use
> > "opb" here.
> >
> > There is probably a similar problem with the nodes for "plb4",
> > "plb5" and "ebc",
> 
> It makes sense for generic code to always if it is asked
> to match for "vendor-code,some-name" also to match on
> plain "some-name".  Well unless people start doing crazy
> things like naming something "vendor-code,pci" which
> isn't PCI compatible or something -- in that case there
> could be a function that matches on exact name only, or
> the caller can deal with it itself perhaps.
> 
> But in most cases the matching-without-prefix should work
> fine.

but is it really the right thing to call it "ibm,plb"
when the identical macro is used on amcc based systems?

I think that was our reasoning when we introduced the
code in linux to scan for "plb5", "plb4" and "opb" buses.

Changing the "device-type" now would result in the final
product to not work on the 2.6.20 kernel, which was released
with the code only scanning for the short names.

Still, it's probably a good idea to list both variants
in compatible, e.g.

type="plb4", compatible="ibm,plb\0ibm,plb4\0plb"

on CAB/axon, and

type="ibm,plb", compatible="ibm,plb4\0plb4\0plb"

on ebony and others. Do you think it makes sense to do it this
way, or should we rather adopt the axon style on the 440 boards?

> > as well as the "compatible" property of the
> > serial port, which, as you noted earlier is "ns16550" on
> > ebony and "ns16750" on axon, although it is exactly the same
> > macro.
> 
> So the "compatible" property should read ns16750, ns16550,
> ns16450, i8250.  The kernel really only needs the device
> to be compatible to the 8250; but since lots of device trees
> mention only the newer UART types, you have to match on those
> too.

Right, that sounds completely correct. I think I've done the
right thing in of_serial already. Christian, please check
what the firmware does today, and make sure to change it
accordingly.
We probably also need a volunteer to clean up the legacy_serial
code for this, it's grown pretty messy by now.

	Arnd <><
--Boundary-01=_hez2F5cRX5OyK9j
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:11pt;font-family:Nimbus Mono L">
<p>On Tuesday 20 February 2007 16:25, Segher Boessenkool wrote:</p>
<p>&gt; &gt;&gt; And the ebony dts also has the a bus type of &quot;ibm,opb&quot; as well.</p>
<p>&gt; &gt;</p>
<p>&gt; &gt; We should really get a common name for these. I don't remember</p>
<p>&gt; &gt; what the discussions were, but it seems we came up with different</p>
<p>&gt; &gt; results for Axon and ppc4xx, which is very bad.</p>
<p>&gt; </p>
<p>&gt; &quot;Very bad&quot;...  Well sure it's less than desirable, but</p>
<p>&gt; we have to deal with this problem anyway already.</p>
<p>&gt; </p>
<p>&gt; &gt; Using type &quot;ibm,opb&quot; rather than just &quot;opb&quot; makes sense to me,</p>
<p>&gt; &gt; but I don't know if we already have shipping systems that use</p>
<p>&gt; &gt; &quot;opb&quot; here.</p>
<p>&gt; &gt;</p>
<p>&gt; &gt; There is probably a similar problem with the nodes for &quot;plb4&quot;,</p>
<p>&gt; &gt; &quot;plb5&quot; and &quot;ebc&quot;,</p>
<p>&gt; </p>
<p>&gt; It makes sense for generic code to always if it is asked</p>
<p>&gt; to match for &quot;vendor-code,some-name&quot; also to match on</p>
<p>&gt; plain &quot;some-name&quot;.  Well unless people start doing crazy</p>
<p>&gt; things like naming something &quot;vendor-code,pci&quot; which</p>
<p>&gt; isn't PCI compatible or something -- in that case there</p>
<p>&gt; could be a function that matches on exact name only, or</p>
<p>&gt; the caller can deal with it itself perhaps.</p>
<p>&gt; </p>
<p>&gt; But in most cases the matching-without-prefix should work</p>
<p>&gt; fine.</p>
<p></p>
<p>but is it really the right thing to call it &quot;ibm,plb&quot;</p>
<p>when the identical macro is used on amcc based systems?</p>
<p></p>
<p>I think that was our reasoning when we introduced the</p>
<p>code in linux to scan for &quot;plb5&quot;, &quot;plb4&quot; and &quot;opb&quot; buses.</p>
<p></p>
<p>Changing the &quot;device-type&quot; now would result in the final</p>
<p>product to not work on the 2.6.20 kernel, which was released</p>
<p>with the code only scanning for the short names.</p>
<p></p>
<p>Still, it's probably a good idea to list both variants</p>
<p>in compatible, e.g.</p>
<p></p>
<p>type=&quot;plb4&quot;, compatible=&quot;ibm,plb\0ibm,plb4\0plb&quot;</p>
<p></p>
<p>on CAB/axon, and</p>
<p></p>
<p>type=&quot;ibm,plb&quot;, compatible=&quot;ibm,plb4\0plb4\0plb&quot;</p>
<p></p>
<p>on ebony and others. Do you think it makes sense to do it this</p>
<p>way, or should we rather adopt the axon style on the 440 boards?</p>
<p></p>
<p>&gt; &gt; as well as the &quot;compatible&quot; property of the</p>
<p>&gt; &gt; serial port, which, as you noted earlier is &quot;ns16550&quot; on</p>
<p>&gt; &gt; ebony and &quot;ns16750&quot; on axon, although it is exactly the same</p>
<p>&gt; &gt; macro.</p>
<p>&gt; </p>
<p>&gt; So the &quot;compatible&quot; property should read ns16750, ns16550,</p>
<p>&gt; ns16450, i8250.  The kernel really only needs the device</p>
<p>&gt; to be compatible to the 8250; but since lots of device trees</p>
<p>&gt; mention only the newer UART types, you have to match on those</p>
<p>&gt; too.</p>
<p></p>
<p>Right, that sounds completely correct. I think I've done the</p>
<p>right thing in of_serial already. Christian, please check</p>
<p>what the firmware does today, and make sure to change it</p>
<p>accordingly.</p>
<p>We probably also need a volunteer to clean up the legacy_serial</p>
<p>code for this, it's grown pretty messy by now.</p>
<p></p>
<p>	Arnd &lt;&gt;&lt;</p>
</body></html>
--Boundary-01=_hez2F5cRX5OyK9j--
