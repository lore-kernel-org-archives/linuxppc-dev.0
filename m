Return-Path: <thomas.abraham@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20110131215935.26336.32719.stgit@localhost6.localdomain6>
References: <20110131215935.26336.32719.stgit@localhost6.localdomain6>
Date: Fri, 11 Feb 2011 16:22:49 +0530
Message-ID: <AANLkTinwxPhCs2rXMAVZWha-YE_oNpbmENXCdX=ybjg+@mail.gmail.com>
Subject: Re: [RFC] dt: add of_platform_bus_snoop() which attaches nodes to
	devices
From: Thomas Abraham <thomas.abraham@linaro.org>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	linaro-dev@lists.linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On 1 February 2011 03:31, Grant Likely <grant.likely@secretlab.ca> wrote:
> This patch implements an alternate method for using device tree data
> for populating machine device registration. =A0Traditionally, board
> support has directly generated and registered devices based on nodes
> in the device tree. =A0The board support code starts at the root of the
> tree and begins allocating devices for each device node it finds.
> Similarly, bus drivers (i2c, spi, etc.) use their child nodes to
> register child devices. =A0This model can be seen in almost all the power=
pc
> board ports (arch/powerpc/platforms/*).
>
> However, for many of the ARM SoCs, there already exists complete board
> support for many SoCs that have their own code for registering the
> basic set of platform devices with non-trivial dependencies on clock
> structure and machine specific platform code. =A0While starting at the
> base of the tree and working up is certainly possible, it requires
> modifying a lot of machine support code to get it working.
>
> Instead, this patch provides an alternate approach. =A0Instead of
> starting at the root of the tree and working up, this patch allows the
> SoC support code to register its standard set of platform devices in
> the normal way. =A0However, it also registers a platform_bus notifier
> function which compares platform_device registrations with data in the
> device tree. =A0Whenever it finds a matching node, it increments the
> node reference count and assigns it to the device's of_node pointer so
> that it is available for the device driver to use and bind against.
> For example, an spi master driver would have access to the spi node
> which contains information about all the spi slaves on the bus.
>
> An example usage of this facility is to allow a single 'devicetree'
> board support file to support multiple machines all using the same
> SoC. =A0The common code would register SoC devices unconditionally, and
> the board support code would depend entirely on device tree data.
>
> Note: Board ports using this facility are still required to provide a
> fully populated device tree blob. =A0It is not a shortcut to providing
> an accurate device tree model of the machine to the point that it
> would be reasonably possible to switch to a direct registration model
> for all devices without change the device tree. =A0ie. The SoC still
> needs to be correctly identified and there should be nodes for all the
> discrete devices.
>
> I'm not convinced that this is the model to pursue over the long term,
> but it greatly simplifies the task of getting device tree support up
> and running, and it provides a migration path to full dt device
> registration (if it makes sense to do so).
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

I have used this patch for Samsung's smdkv310 board and it works fine.
There are 4 uart port nodes in the dts file and the platform devices
for the 4 uart ports (which are instantiated in the platform code) get
the of_node pointer when the of_platform_bus_snoop function is used.
The driver then is able to pick up information from the device node.
The tough part, though, is moving the existing platform data into the
device tree and having the driver parse that data from the device
node.

Regards,
Thomas.
