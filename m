Return-Path: <hch@lst.de>
Date: Sun, 9 Jan 2005 17:06:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jerome Glisse <j.glisse@gmail.com>
Message-ID: <20050109160614.GA22839@lst.de>
References: <4240b916050109072621440269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4240b916050109072621440269@mail.gmail.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: U3 G5 AGP support patch (v4)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

+static struct device_node* uninorth_node __pmacdata;
+static u32 __iomem * uninorth_base __pmacdata;

static struct device_node *uninorth_node __pmacdata;
static u32 __iomem *uninorth_base __pmacdata;

+	if(uninorth_rev == 0x21) {

	if (uninorth_rev == 0x21) {

+	if((uninorth_rev >= 0x30) && (uninorth_rev <= 0x33)) {

	if ((uninorth_rev >= 0x30) && (uninorth_rev <= 0x33)) {

+	if (agp_bridge->dev->device == PCI_DEVICE_ID_APPLE_U3_AGP) {
+			/* This is an AGP V3 */
+			agp_device_command(command, TRUE);
+	} else {
+			/* AGP V2 */
+			agp_device_command(command, FALSE);
+	}

double-indentation, also please use 1/0 instead of TRUE/FALSE.

+static struct aper_size_info_32 u3_sizes[8] =
+{
+/*
+ * Not sure that uninorth3 supports that high aperture sizes but it
+ * would strange if it did not :)
+ */

comment before the struct declearation, please, aka

/*
 * Not sure that uninorth3 supports that high aperture sizes but it
 * would strange if it did not :)
 */
static struct aper_size_info_32 u3_sizes[8] = {

+	uninorth_node = of_find_node_by_name(NULL, "uni-n");
+	/* Locate G5 u3 */
+	if (uninorth_node == NULL) {
+		uninorth_node = of_find_node_by_name(NULL, "u3");
+	}

	/* Locate G5 u3 */
	uninorth_node = of_find_node_by_name(NULL, "uni-n");
	if (!uninorth_node)
		uninorth_node = of_find_node_by_name(NULL, "u3");

+	/*
+	 * Set specific functions & values for agp3 controller.
+	 */
+	if (pdev->device == PCI_DEVICE_ID_APPLE_U3_AGP) {
+		uninorth_agp_driver.insert_memory  = uninorth3_insert_memory;
+		uninorth_agp_driver.aperture_sizes = (void *)u3_sizes;
+		uninorth_agp_driver.num_aperture_sizes = 8;

Please delcare separate driver instance instead of overriding.


And asm-ppc64 is still missing an agp.h, no?
